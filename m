Return-Path: <linux-pci+bounces-34755-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F36B3603C
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 14:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2822B1BA4A52
	for <lists+linux-pci@lfdr.de>; Tue, 26 Aug 2025 12:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E324A2D3A80;
	Tue, 26 Aug 2025 12:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b="COXXw33r"
X-Original-To: linux-pci@vger.kernel.org
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AE02D0C64
	for <linux-pci@vger.kernel.org>; Tue, 26 Aug 2025 12:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.155.224.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756212896; cv=none; b=nyTzeydfnLS2eR3x/RVjfxhsay1eoVOB6kbcLr7xRITFFHxxtbGhjKlnMJIdfcbOxthyBdlcLamsqAWn1sBmjL4pL3ilbCx2C7DI8uDPCWGmE2SY/UKXltA6m/81jBeTbv+WL4H5wOt7oMDyBIDEeuIegR95MISv88XrQW0hzjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756212896; c=relaxed/simple;
	bh=h5UM7cVxanj4nvpEVZuL+R2iOLoy5jUr+m3s0ccFhUU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=PkYxhWl/5SE6CLpdi2PcUS/Nx+f71cZTrnLTTo0Ml6DiEs4DIDjaLpfCexLtUtRCqnVcxzjEyqXihUJCBAJGIGYC9EJNtfdMZXJQzfIjvPnJIzMnwr3xqREWPVFsgciO2OI8TYG/sPY3mAp47RrDRtx8iAYjArvrAy1nWYkyMRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; spf=pass smtp.mailfrom=raptorengineering.com; dkim=pass (1024-bit key) header.d=raptorengineering.com header.i=@raptorengineering.com header.b=COXXw33r; arc=none smtp.client-ip=23.155.224.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raptorengineering.com
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 9EAD88287446;
	Tue, 26 Aug 2025 07:48:46 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id u-SayVgJgexz; Tue, 26 Aug 2025 07:48:44 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 117F48288753;
	Tue, 26 Aug 2025 07:48:44 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 117F48288753
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1756212524; bh=pWBx3up5OtBfgCsdwpnRNbFyf1O3nmU2gJO4Esh65HI=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=COXXw33r7RVLKNFi9g+NSx82NQeX917D2q8nxryyvQNeUl3+TyxDRru8Gc3R5072K
	 DupvJeA8kiGEPr2Wc7IpJZaJFTu6fOnhM2Q3v7NC/1bslDMq0Pim2bNZ2/qPWDjTTC
	 uEESr/kW3WC8XAqEMkSqgqkISUqWWJA+W3whJjLo=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id PmsbtlH_Uv4C; Tue, 26 Aug 2025 07:48:43 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id BBFD08287446;
	Tue, 26 Aug 2025 07:48:43 -0500 (CDT)
Date: Tue, 26 Aug 2025 07:48:40 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci <linux-pci@vger.kernel.org>, 
	mahesh <mahesh@linux.ibm.com>, Oliver <oohall@gmail.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, 
	Lukas Wunner <lukas@wunner.de>
Message-ID: <1822371399.1670864.1756212520886.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <a6611c3f-79e7-4588-bdfd-5ccf5ab56c81@oss.qualcomm.com>
References: <988492931.1308196.1750174918075.JavaMail.zimbra@raptorengineeringinc.com> <a6611c3f-79e7-4588-bdfd-5ccf5ab56c81@oss.qualcomm.com>
Subject: Re: [PATCH v10] PCI: Add pcie_link_is_active() function
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC139 (Linux)/8.5.0_GA_3042)
Thread-Topic: Add pcie_link_is_active() function
Thread-Index: 8CHEGvz19xP174hdzX7irCatg7y5qw==


----- Original Message -----
> From: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
> To: "Timothy Pearson" <tpearson@raptorengineering.com>, "Bjorn Helgaas" <helgaas@kernel.org>
> Cc: "linux-pci" <linux-pci@vger.kernel.org>, "mahesh" <mahesh@linux.ibm.com>, "Oliver" <oohall@gmail.com>, "Madhavan
> Srinivasan" <maddy@linux.ibm.com>, "Michael Ellerman" <mpe@ellerman.id.au>, "Lukas Wunner" <lukas@wunner.de>
> Sent: Tuesday, August 26, 2025 2:04:56 AM
> Subject: Re: [PATCH v10] PCI: Add pcie_link_is_active() function

> On 6/17/2025 9:11 PM, Timothy Pearson wrote:
>> Add pcie_link_is_active() function to check if the physical PCIe link is
>> active, replacing duplicate code in multiple locations.
>> 
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> Signed-off-by: Shawn Anastasio <sanastasio@raptorengineering.com>
>> Signed-off-by: Timothy Pearson <tpearson@raptorengineering.com>
>> ---
> Hi Timothy,
> 
> Are you going to respin this patch.
> If not I can take this patch in my series which I am going to post next
> week.
> 
> - Krishna Chaitanya.

If you'd like to take it please go ahead.  Thanks!

