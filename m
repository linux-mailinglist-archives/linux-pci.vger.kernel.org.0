Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2362D10074D
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2019 15:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfKROYb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Nov 2019 09:24:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:42750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726627AbfKROYb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Nov 2019 09:24:31 -0500
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 243BD20692;
        Mon, 18 Nov 2019 14:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574087070;
        bh=MmJPqaX8nGIZrh4Dibpts0t0Dtr9+u4xiU8n8NZNzFk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=0DBwzJUVz38PqTslrSrR99DBp0hhvJbtqNfpwBRRVJbr7NcsFqytNsE/o0HBgS1kJ
         m3e/oSIVp8rb5/IncQZO8v5/NjAcHywY71Ipbs2juUEgDOTwnwOZ5+drB+CyqiaBqw
         vN5Ch3XYMbzCfTXFa8f7oxKXQ5BFt8J/2GNyvQOo=
Date:   Mon, 18 Nov 2019 08:24:28 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>, shawn.lin@rock-chips.com,
        lorenzo.pieralisi@arm.com, andrew.murray@arm.com, heiko@sntech.de,
        lgirdwood@gmail.com, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] PCI: rockchip: Simplify optional regulator handling
Message-ID: <20191118142428.GA27459@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191118115930.GC9761@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 18, 2019 at 11:59:30AM +0000, Mark Brown wrote:
> On Sat, Nov 16, 2019 at 12:54:20PM +0000, Robin Murphy wrote:
> > Null checks are both cheaper and more readable than having !IS_ERR()
> > splattered everywhere.
> 
> > -	if (IS_ERR(rockchip->vpcie3v3))
> > +	if (!rockchip->vpcie3v3)
> >  		return;
> >  
> >  	/*
> > @@ -611,6 +611,7 @@ static int rockchip_pcie_parse_host_dt(struct rockchip_pcie *rockchip)
> >  		if (PTR_ERR(rockchip->vpcie12v) != -ENODEV)
> >  			return PTR_ERR(rockchip->vpcie12v);
> >  		dev_info(dev, "no vpcie12v regulator found\n");
> > +		rockchip->vpcie12v = NULL;
> 
> According to the API NULL is a valid regulator.  We don't currently
> actually do this but it's storing up surprises if you treat it as
> invalid.

I don't know anything about the regulator API, but the fact that NULL
can be a valid regulator is itself a little surprising :)
