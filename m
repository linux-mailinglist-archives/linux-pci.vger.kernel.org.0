Return-Path: <linux-pci+bounces-5856-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEE389B5C8
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 04:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DBD11F213CC
	for <lists+linux-pci@lfdr.de>; Mon,  8 Apr 2024 02:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEAA10E9;
	Mon,  8 Apr 2024 02:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3fwipnk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B614A1D;
	Mon,  8 Apr 2024 02:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712541806; cv=none; b=Vwv5SOgg3fKW829454Kp7okGjaEUAnnrfG/nEugQApcGcq7jdann5akl0WE2xV/N2JKDuRQ0BFozl8mCbFcsdcrqXM4gVuFNX+IAF590sdUQK1Q3Rxw3mVuINWtB/1UC6hpNSKjvf2Rim2X0jlf6q5z7nA7bAVLzJy772BLoCHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712541806; c=relaxed/simple;
	bh=fYm7KFC5U/QW6ssZd3s4lbnjdDOAG3MIETvCHATRU/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNmS0upVfT0I9UAT4/00wICgw8xBoGUfBWDuOdCQa7SeJFfTBovEOhN6aVr6Dse9SK8xvq3alFRlPpqR2WzLqEYXkwDtaf02s6lGmIf57osZIv2eblTXiuxv0ELTOEsrOVmGsgLNpKOPE2njD4Aaq+uUg4pPTKIlrCyoJRt6VNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3fwipnk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B5A1C433C7;
	Mon,  8 Apr 2024 02:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712541805;
	bh=fYm7KFC5U/QW6ssZd3s4lbnjdDOAG3MIETvCHATRU/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i3fwipnkx6662oFevfQz2J4ciSbXSf21so8hiZqbSljhAvlKH8VYiNvw+NRr6GsN7
	 hp/Z6Qb4NkhLbCepMYG9xa0vOLCxBiSQZ8bxY0JHyt2em0USzvzC2JJuFkypiE0KwF
	 TS0qrxtN3JzKro+CKn5Ck3Gdyq7EIWSdW569C1l+sjL8+J4qMr7OvtsLLWoR1g75PX
	 GhVO5BRABtyRiHOri+SFI2hEprS/UBvoL9O9nXeqZZHsQ279JFsQgR5I22Do2WxhUi
	 /7mDX+yEFbhwc6+DmmRSUeRqQp+PyI1Zc2MYXayBMIxQVtaLSWfbkh2cr2pgHPoktY
	 MTuhaCFUeJCmQ==
Date: Sun, 7 Apr 2024 19:03:23 -0700
From: PJ Waskiewicz <ppwaskie@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] cxl/acpi.c: Add buggy BIOS hint for CXL ACPI lookup
 failure
Message-ID: <ZhNQa8wAflycciNA@snoopy>
References: <20240407210526.8500-1-ppwaskie@kernel.org>
 <ZhMP-NBMb387KD4Y@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZhMP-NBMb387KD4Y@wunner.de>

On 24/04/07 11:28PM, Lukas Wunner wrote:

Hi Lukas,

> On Sun, Apr 07, 2024 at 02:05:26PM -0700, ppwaskie@kernel.org wrote:
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -504,7 +504,7 @@ static int cxl_get_chbs(struct device *dev, struct acpi_device *hb,
> >  
> >  	rc = acpi_evaluate_integer(hb->handle, METHOD_NAME__UID, NULL, &uid);
> >  	if (rc != AE_OK) {
> > -		dev_err(dev, "unable to retrieve _UID\n");
> > +		dev_err(dev, "unable to retrieve _UID. Potentially buggy BIOS\n");
> >  		return -ENOENT;
> >  	}
> 
> dev_err(dev, FW_BUG "unable to retrieve _UID\n");
>              ^^^^^^
> 
> There's a macro for that.

Doh...it's been awhile since I've crossed buggy BIOS's.  Thanks for the
review and comment.

Updated patch:

cxl/acpi.c: Add buggy BIOS hint for CXL ACPI lookup failure

From: PJ Waskiewicz <ppwaskie@kernel.org>

Currently, Type 3 CXL devices (CXL.mem) can train using host CXL
drivers on Emerald Rapids systems.  However, on some production
systems from some vendors, a buggy BIOS exists that improperly
populates the ACPI => PCI mappings.  This leads to the cxl_acpi
driver to fail probe when it cannot find the root port's _UID, in
order to look up the device's CXL attributes in the CEDT.

Add a bit more of a descriptive message that the lookup failure
could be a bad BIOS, rather than just "failed."

v2: Updated message to use existing FW_BUG macro

Signed-off-by: PJ Waskiewicz <ppwaskie@kernel.org>
---
 drivers/cxl/acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index af5cb818f84d..d321cfbd4682 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -504,7 +504,7 @@ static int cxl_get_chbs(struct device *dev, struct acpi_device *hb,
 
 	rc = acpi_evaluate_integer(hb->handle, METHOD_NAME__UID, NULL, &uid);
 	if (rc != AE_OK) {
-		dev_err(dev, "unable to retrieve _UID\n");
+		dev_err(dev, FW_BUG "unable to retrieve _UID\n");
 		return -ENOENT;
 	}
 
-- 
2.40.1

