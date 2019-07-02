Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB315D5A3
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2019 19:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfGBRuo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Jul 2019 13:50:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:60830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfGBRuo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Jul 2019 13:50:44 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1137F21721;
        Tue,  2 Jul 2019 17:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562089843;
        bh=S41st5cRffWCwI1px1NAqUx7dKAecFlA2dZOtrgmC3Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fgZY7FqHJVIFZg2bWiE/eQXMoLB+ah85jd73eCP2hrWj1D42Gv+rAFfei6zEuyW+K
         EjN1Ah8vStBEEHprvaSzvdIMyRbaLJGU1mwnabkLyV4OWFkrx4InaKwM66nU2eteFu
         Pd5P8GUFjtBBvPdTi6iGRXDa01kM7MCIl+Ubz8Nw=
Date:   Tue, 2 Jul 2019 12:50:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     andy.shevchenko@gmail.com, sebott@linux.ibm.com, lukas@wunner.de,
        gustavo@embeddedor.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingfangsen@huawei.com
Subject: Re: [PATCH] net: pci: Fix hotplug event timeout with shpchp
Message-ID: <20190702175040.GA128603@google.com>
References: <1562074519-205047-1-git-send-email-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1562074519-205047-1-git-send-email-linmiaohe@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 02, 2019 at 01:35:19PM +0000, Miaohe Lin wrote:
> Hotplug a network card would take more than 5 seconds
> in qemu + shpchp scene. It’s because 5 seconds
> delayed_work in func handle_button_press_event with
> case STATIC_STATE. And this will break some
> protocols with timeout within 5 seconds.

I'm dropping this because of the required delay pointed out by Lukas.

If you think we still need to do something here, please clarify the
situation.  Are you hot-adding?  Hot-swapping?  Since you mention a
protocol timeout, I suspect the latter, e.g., maybe you had an
existing device with connections already open, and you want to replace
it with a new device while preserving those open connections?

We do have to preserve the existing user experience, e.g., delays to
allow operators to recover from mistaken latch opens or button
presses.  But if we knew more about what you're trying to do, maybe we
could figure out another approach.

> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  drivers/pci/hotplug/shpchp_ctrl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/hotplug/shpchp_ctrl.c b/drivers/pci/hotplug/shpchp_ctrl.c
> index 078003dcde5b..cbb00acaba0d 100644
> --- a/drivers/pci/hotplug/shpchp_ctrl.c
> +++ b/drivers/pci/hotplug/shpchp_ctrl.c
> @@ -478,7 +478,7 @@ static void handle_button_press_event(struct slot *p_slot)
>  		p_slot->hpc_ops->green_led_blink(p_slot);
>  		p_slot->hpc_ops->set_attention_status(p_slot, 0);
>  
> -		queue_delayed_work(p_slot->wq, &p_slot->work, 5*HZ);
> +		queue_delayed_work(p_slot->wq, &p_slot->work, 0);
>  		break;
>  	case BLINKINGOFF_STATE:
>  	case BLINKINGON_STATE:
> -- 
> 2.21.GIT
> 
