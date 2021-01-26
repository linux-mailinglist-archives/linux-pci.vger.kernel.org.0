Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25AB1303A98
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jan 2021 11:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404233AbhAZKnD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jan 2021 05:43:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404178AbhAZKkj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Jan 2021 05:40:39 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB5AC06174A;
        Tue, 26 Jan 2021 02:39:57 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id B900223E6C;
        Tue, 26 Jan 2021 11:39:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1611657595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dCH/YXfZ9HXdQBHPo7Nn9zVU+J0dd/QGNvh+wOZ/2X0=;
        b=GKqOOoubkXGqrd/zE5rlnqsPTy9r0oLk3z+IM3Sf/2UoHZvkZLtvwOhunJfmhZwOa6B0aK
        cdugxcwYILhWGaAagQO7wh0vXI4z0begDwW+Die9587dy0ps0+RVeAl6opeJ7UERxokhLv
        UX9LiZSc46WBwqVpsZdf7Ik5uNyVZGk=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 26 Jan 2021 11:39:54 +0100
From:   Michael Walle <michael@walle.cc>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH] PCI: dwc: layerscape: convert to
 builtin_platform_driver()
In-Reply-To: <20210126100256.GA20547@e121166-lin.cambridge.arm.com>
References: <20210120105246.23218-1-michael@walle.cc>
 <20210126100256.GA20547@e121166-lin.cambridge.arm.com>
User-Agent: Roundcube Webmail/1.4.10
Message-ID: <1a36ef741c5ab2a6e90b38c58944aa25@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 2021-01-26 11:02, schrieb Lorenzo Pieralisi:
> On Wed, Jan 20, 2021 at 11:52:46AM +0100, Michael Walle wrote:
>> fw_devlink will defer the probe until all suppliers are ready. We 
>> can't
>> use builtin_platform_driver_probe() because it doesn't retry after 
>> probe
>> deferral. Convert it to builtin_platform_driver().
>> 
>> Fixes: e590474768f1 ("driver core: Set fw_devlink=on by default")
> 
> I will have to drop this Fixes: tag if you don't mind, it is not
> in the mainline.

That commit is in Greg's for-next tree:
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?h=driver-core-next&id=e590474768f1cc04852190b61dec692411b22e2a

I was under the impression there are other commits with this
particular fixes tag, too. Either it was removed from
for-next queues or I was confused.

But I'm fine with removing the tag, assuming this will end
up together with the "driver core: Set fw_devlink=on by default"
commit in 5.11.

-michael
