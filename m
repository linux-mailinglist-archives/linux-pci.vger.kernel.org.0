Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95C924073F5
	for <lists+linux-pci@lfdr.de>; Sat, 11 Sep 2021 01:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234789AbhIJXfN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Sep 2021 19:35:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:35440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234689AbhIJXfN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Sep 2021 19:35:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6ED4261212;
        Fri, 10 Sep 2021 23:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631316841;
        bh=AlGT+1ZkR5OARaW5Qf3AVAgmSVngDxhk8G1V2NgY8A0=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=LSWH98E9Gp5vV79OPvBxPiatelKbDD5+9HxdN1YHHO4924YI1NgzILiFxLXotbXLx
         86ptja5pEcL1FEipFRXC4IZDhGH6DztwwC712yTJl81CWT0fv1orEbu+8etn7MsPIu
         D4Dp4eDhht2mKDBdHn0rnTwHksyO88yl7deMkKrnUM6iNpVU4a+xuR5KpSP+HY5tLV
         C8Aw47BSI6aNoLfmxe4a6C/RzFVCgbEVhEesi7NVe47nmICW1Ax6PyHfMqbL9tJCR+
         YsTPbrgdaRv+xCOGhKrnosM4p5ZGVqlv+CONxR11zR07FaWusdOhfaVhBmrWwvti7p
         OsNjVv664L+nw==
Date:   Fri, 10 Sep 2021 16:34:00 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Jan Beulich <jbeulich@suse.com>
cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 10/12] xen-pcifront: this module is PV-only
In-Reply-To: <bbfb4191-9e34-53da-f179-4549b10dcfb3@suse.com>
Message-ID: <alpine.DEB.2.21.2109101633530.10523@sstabellini-ThinkPad-T480s>
References: <588b3e6d-2682-160c-468e-44ca4867a570@suse.com> <bbfb4191-9e34-53da-f179-4549b10dcfb3@suse.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 7 Sep 2021, Jan Beulich wrote:
> It's module init function does a xen_pv_domain() check first thing.
> Hence there's no point building it in non-PV configurations.
> 
> Signed-off-by: Jan Beulich <jbeulich@suse.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>

> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -110,7 +110,7 @@ config PCI_PF_STUB
>  
>  config XEN_PCIDEV_FRONTEND
>  	tristate "Xen PCI Frontend"
> -	depends on X86 && XEN
> +	depends on XEN_PV
>  	select PCI_XEN
>  	select XEN_XENBUS_FRONTEND
>  	default y
> 
