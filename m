Return-Path: <linux-pci+bounces-15709-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 065E19B7B6E
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 14:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68768B21007
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 13:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD9919DF4C;
	Thu, 31 Oct 2024 13:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="LBXgRZnt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB2C1465A5;
	Thu, 31 Oct 2024 13:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730380330; cv=none; b=iiWxdV3nc8uWPtDD5/iB35uZ6q+2JBD67jnxBzN0fRkMK2jdM1AS3L0wZNWPA3/6VxAi8oFB5lgoQmltIR349dEvs5ymIpTLFv5/RZrs9YK+kt8C4ucea4MohE2ICIsQmdhkNN5p4FXQPqn4KjbGHYFOIalXjf4eSUPMCrqYSwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730380330; c=relaxed/simple;
	bh=6TuQqSwruTS6m11Y7D9ivpGZrpvPRnPeulZImCOw1Fw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=gh2kzZp32AUgDcpQvl3Ivry5BO1vJaKtHVH7EdbGS/nzJD33lFgMpn6nQKYYnUdHQDFUVObAD3aTsjzUVrRlAY/gxs+NVI91hvQwfQ1gRuj9q+uy0YjppkdQrUfjiMbPnVaRnL9vbIC1YIXXqTv8Ozwr/BJklKbldhp0TdQ2XFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=LBXgRZnt; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0FFD640E0219;
	Thu, 31 Oct 2024 13:11:59 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id zQMJoO691PFu; Thu, 31 Oct 2024 13:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730380312; bh=gGmAiRP3MDLi3/WSlQhPjv7Q4SdbAZycztTpxfnOqJc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=LBXgRZnt36oS0GnwFS/semXj4U/SRk+66fDLV67KDPEfy7cpqJtVyqcqkMxEu+ADH
	 z1HwPAK/fy0WTRRNANMbaiEbQYHRg4o+etMiWIjyMweYWwCi+yE6VBUzh1BJBhqeV/
	 uApnefSimZr77YtmEKOVb089bc7rL7bsbuDZrUqlbaSfCeIiHzU2mBR2IsFVP+LibB
	 /wxxJ4x33LUo4n48/lcbD2ExbgcBjmyQaVvqjULjCPXP7xG4ZWK13hgSukVsSHOOqk
	 yUIKMkPB5M4/rym7FIiv+yO2gR34PDrMPS9W4w0BpQFWsxl72RTIJTS68ZCtmP8Bwd
	 JeqPR3crUyB/TmpXjW7IJ8MAT9z0Q9MambHuF0ezfXklfhVMeE4M5noqauVulBP3ma
	 kLMmRPnOG/rlFa++4j8PTXMdS5qw6vl6uSh5RIyg2ZD50eq0SlDxFO9xA5wPaQRGrA
	 bEBmF6yoGmkgvJUTT+j4wQbdLKGTPZWXvarWJgIdH/ob8yVeexFbXYa55n/KKVLsNU
	 +ST9z2E99uruIevN3PtfskpGFyQrmZc4uEAZR/rtcPJeN9oB9dfi86lDEgreWtEgIc
	 5Qz6BzjGEZo8v5gvqZny54GukZIbOI2iGuP4WbA703gERFPTkbmKZl1U5WoU9ee1/F
	 7DeS3Kcqq1lz23cuT2QuvTQU=
Received: from [IPv6:::1] (unknown [IPv6:2a02:3033:20b:4a3d:808a:1ce0:7970:d8a4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 546ED40E0028;
	Thu, 31 Oct 2024 13:11:30 +0000 (UTC)
Date: Thu, 31 Oct 2024 14:11:25 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
CC: Yazen Ghannam <yazen.ghannam@amd.com>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Luck, Tony" <tony.luck@intel.com>, "x86@kernel.org" <x86@kernel.org>,
 "avadhut.naik@amd.com" <avadhut.naik@amd.com>,
 "john.allen@amd.com" <john.allen@amd.com>,
 "mario.limonciello@amd.com" <mario.limonciello@amd.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "Shyam-sundar.S-k@amd.com" <Shyam-sundar.S-k@amd.com>,
 "richard.gong@amd.com" <richard.gong@amd.com>,
 "jdelvare@suse.com" <jdelvare@suse.com>,
 "linux@roeck-us.net" <linux@roeck-us.net>,
 "clemens@ladisch.de" <clemens@ladisch.de>,
 "hdegoede@redhat.com" <hdegoede@redhat.com>,
 "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 "naveenkrishna.chatradhi@amd.com" <naveenkrishna.chatradhi@amd.com>,
 "carlos.bilbao.osdev@gmail.com" <carlos.bilbao.osdev@gmail.com>
Subject: =?US-ASCII?Q?RE=3A_=5BPATCH_02/16=5D_x86/amd=5Fnb=3A_Restri?=
 =?US-ASCII?Q?ct_init_function_to_AMD-based_systems?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CY8PR11MB713456E1E8EF5257F0DEE9F089552@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20241023172150.659002-1-yazen.ghannam@amd.com> <20241023172150.659002-3-yazen.ghannam@amd.com> <CY8PR11MB71340D079448528FD548F73289552@CY8PR11MB7134.namprd11.prod.outlook.com> <20241031103642.GCZyNdumQSdi76CA3w@fat_crate.local> <CY8PR11MB713456E1E8EF5257F0DEE9F089552@CY8PR11MB7134.namprd11.prod.outlook.com>
Message-ID: <D127222A-7B65-452B-9647-89F2CFD9E7AF@alien8.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 31, 2024 12:50:10 PM GMT+01:00, "Zhuo, Qiuxu" <qiuxu=2Ezhuo@inte=
l=2Ecom> wrote:
>> From: Borislav Petkov <bp@alien8=2Ede>
>> [=2E=2E=2E]
>>=20
>> On Thu, Oct 31, 2024 at 08:09:14AM +0000, Zhuo, Qiuxu wrote:
>> > This function could fail and return an error=2E
>> > Is an early return with an error code needed if this function fails?
>>=20
>> No, grep for amd_northbridges=2Enum checks in the code=2E
>
>If the return value of amd_cache_northbridges() isn't used in any place,=
=20
>make it return void?
>
>-Qiuxu

Feel free to propose patches *after* the dust around that area settles=2E
--=20
Sent from a small device: formatting sucks and brevity is inevitable=2E 

