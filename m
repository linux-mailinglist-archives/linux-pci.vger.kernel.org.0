Return-Path: <linux-pci+bounces-12383-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 074D1963313
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 22:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A9C01C23E17
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 20:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E6A15C146;
	Wed, 28 Aug 2024 20:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUGv8PmY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE84156C6F;
	Wed, 28 Aug 2024 20:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724878440; cv=none; b=ofnvhr10aW3cVdH+G/yuSd70In4OkGUIKJTg+cBtk+t38/uz3r3ROovc9wNVMw1U7bQA5zhBSrZX21WQSgqWLiKDCDnYgqlirsnJdNT0nTUtYmsvMI5JOHwOhMDLWN7vVSL+nDZJKWFkYIGEiecVR6gBBDzoEf+KiWEbMlp8t1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724878440; c=relaxed/simple;
	bh=XAkjYOvWfhrvm/X1rNgkOi5Ip0NoC3OasguBXC06H5w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YsPSsTmV1eHqfEcs0tCAQQM1INlTABf5pk5MtCI4C7YMqL4SDp1Gp+TffWrtIH/sg0HtKReN8OeGyl/+Dac2eb2aTwJ1FTXgcClgEJ9Q38wewYKdkuaAl2KhZwqemKwDT7U8bE+2xpdRx8DAyL6yARhrgJcfTbz0Gf2xsaFidrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUGv8PmY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51FC5C4CEC0;
	Wed, 28 Aug 2024 20:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724878439;
	bh=XAkjYOvWfhrvm/X1rNgkOi5Ip0NoC3OasguBXC06H5w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=oUGv8PmYlxexpSuOdabSUd42Ulupy14Br2vHnnIpEPydK9E/zmcXGN8r4Mt3UckRM
	 EX4aud81Lg6z5GvKU0lwf3PDVszxt0I1SKRfKT7LPrSGcFU34ByGzY7eGmIyaOz9Yt
	 Vw2YMXHKuxnIdxbeVR/8JtBK75VhrX7mT9jAJ0HXi1TG+Rrp4MTvHpXRLkA3Wkjx1/
	 +YrEFUdapuZW+i2eANnUkYw1mb6tcQEHAXJDIaCjd4ljjg6oAnVMjZrF8aHU32dSb2
	 CgvhoFpKXcXs3jmOVJF+1WFa0rznMpEDeowosbHAtzu1MGz6005KDPqsJVy6/15XhY
	 FB8A9qiIk04/A==
Date: Wed, 28 Aug 2024 15:53:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	"Maciej W . Rozycki" <macro@orcam.me.uk>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Duc Dang <ducdang@google.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Stanislav Spassov <stanspas@amazon.de>,
	Rajat Jain <rajatja@google.com>
Subject: Re: [RFC PATCH 1/3] PCI: Wait for device readiness with
 Configuration RRS
Message-ID: <20240828205357.GA36177@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs6kwHX7EIGvnf9_@wunner.de>

[+cc Stanislav, Rajat]

On Wed, Aug 28, 2024 at 06:17:04AM +0200, Lukas Wunner wrote:
> On Tue, Aug 27, 2024 at 06:48:46PM -0500, Bjorn Helgaas wrote:
> > @@ -1311,9 +1320,15 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
> >  			return -ENOTTY;
> >  		}
> >  
> > -		pci_read_config_dword(dev, PCI_COMMAND, &id);
> > -		if (!PCI_POSSIBLE_ERROR(id))
> > -			break;
> > +		if (root && root->config_crs_sv) {
> > +			pci_read_config_dword(dev, PCI_VENDOR_ID, &id);
> > +			if (!pci_bus_crs_vendor_id(id))
> > +				break;
> 
> There was an effort from Amazon back in 2020/2021 to improve CRS support:
> 
> https://lore.kernel.org/linux-pci/20200307172044.29645-1-stanspas@amazon.com/

Thanks for reminding me of that, and I'm sorry that series didn't get
applied back then because it's very similar to this one.

> One suggestion you raised in the subsequent discussion was to use a
> 16-bit (word) instead of a 32-bit (dword) read of the Vendor ID
> register to avoid issues with devices that don't implement CRS SV
> correctly:
> 
> https://lore.kernel.org/linux-pci/20210913160745.GA1329939@bjorn-Precision-5520/

Thanks.  Reading that response, I don't understand my point about using
a 16-bit read.  I mentioned 89665a6a7140 ("PCI: Check only the Vendor
ID to identify Configuration Request Retry"), the commit log of which
points to http://lkml.kernel.org/r/4729FC36.3040000@gmail.com, which
documents several defective devices that have a Vendor ID of 0x0001.

E.g., the Realtek rtl8169 controller mentioned there has Vendor/Device
ID of [0001:8168].  Doing either a 16-bit read or a 32-bit read and
checking the low 16 bits would incorrectly treat that as a Config RRS
completion.

So it *looks* to me like we will time out after 60 seconds and
conclude the device never became ready:

  pci_scan_device(..., timeout=60*1000)
    pci_bus_read_dev_vendor_id
      pci_bus_generic_read_dev_vendor_id
        pci_bus_read_config_dword(PCI_VENDOR_ID, l)  # <--
        # *l == 0x81680001
        if (pci_bus_crs_vendor_id(*l))        # 0x81680001 & 0xffff = 0x0001
          pci_bus_wait_crs(..., timeout=60*1000)
            while (pci_bus_crs_vendor_id(*l)) {
              if (delay > timeout)
                return false;                 # device not ready
              pci_bus_read_config_dword(PCI_VENDOR_ID, l)
            }

That *might* be an argument for doing a 32-bit read and checking for
0xffff0001, since the spec requires all 1's in the extra bytes.  But
I'm not aware of any complaints about these broken devices with a
0x0001 Vendor ID, and the 89665a6a7140 commit log says there are also
defective devices that don't fill the extra bytes with all 1's.

So my inclination is to keep the current code that does a 32-bit read
and checks only the low 16 bits.

> I realize that pci_bus_crs_vendor_id() masks the Device ID bits,
> so probably no biggie.  Just want to make sure all lessons learned
> during previous discussions on this topic are considered. :)


