Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0C7B29A4A0
	for <lists+linux-pci@lfdr.de>; Tue, 27 Oct 2020 07:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506503AbgJ0G2H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Oct 2020 02:28:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:57608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2506457AbgJ0G2G (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Oct 2020 02:28:06 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 521D4207F7;
        Tue, 27 Oct 2020 06:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603780086;
        bh=RHobgh6qhU0nhKYr7NEB/qsfaoFlKTPJZUoZ61lX7MY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rOP9+wbA1pPcguNKPnF3TXtXSMd58M2ETvLXMsJyzYFEilVAOnOLT7Pf8xTNt2eLe
         dgrSvLyl3/F3kpPWARMoOMUcL+ny5RI2YvLJWjvf3zKhtB5N1HlVKlc0Pi9aDCr3NU
         nI3oRTsua87JhN92bZD6SmERl7+xAtEs24ZZknV4=
Date:   Tue, 27 Oct 2020 07:28:02 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "sudeep.dutt@intel.com" <sudeep.dutt@intel.com>,
        "ashutosh.dixit@intel.com" <ashutosh.dixit@intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V3 2/4] misc: vop: do not allocate and reassign the used
 ring
Message-ID: <20201027062802.GC207971@kroah.com>
References: <20201022050638.29641-1-sherry.sun@nxp.com>
 <20201022050638.29641-3-sherry.sun@nxp.com>
 <20201023092650.GB29066@infradead.org>
 <VI1PR04MB4960E9ECD7310B8CA1E053DC92190@VI1PR04MB4960.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB4960E9ECD7310B8CA1E053DC92190@VI1PR04MB4960.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 26, 2020 at 03:04:45AM +0000, Sherry Sun wrote:
> Hi Greg & Christoph,
> 
> > Subject: Re: [PATCH V3 2/4] misc: vop: do not allocate and reassign the used
> > ring
> > 
> > On Thu, Oct 22, 2020 at 01:06:36PM +0800, Sherry Sun wrote:
> > > We don't need to allocate and reassign the used ring here and remove
> > > the used_address_updated flag.Since RC has allocated the entire vring,
> > > including the used ring. Simply add the corresponding offset can get
> > > the used ring address.
> > 
> > Someone needs to verify this vs the existing intel implementations.
> 
> Hi Greg, @gregkh@linuxfoundation.org, sorry I don't have the Intel MIC devices so cannot test it, do you know anyone who can help test this patch changes on the Intel MIC platform? Thanks.

Why not ask the authors/maintainers of that code?

greg k-h
