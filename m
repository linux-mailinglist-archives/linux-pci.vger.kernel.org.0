Return-Path: <linux-pci+bounces-15719-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2CF9B7E99
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 16:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F7AD1F2173A
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 15:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FCA14901B;
	Thu, 31 Oct 2024 15:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amd.com header.i=@amd.com header.b="374d7ZrN"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0805A13342F;
	Thu, 31 Oct 2024 15:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730388899; cv=fail; b=QW74XLC9TlQ3fbMB9KXumMg8ZLB/MfKd4vj70oAFX7t8MpQzqb706+38M5bPRxWwqLBJqt/uLOw97YbQ0jhNkXSwrW0lJj/kABKs9NV9Jv2j+/waXZeE3Fexj9mqcDRsLJQgsZWWP1VSzOAO96iR/36JedZKHV51BT8UWeWHCso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730388899; c=relaxed/simple;
	bh=OtEsPOEG1qlZq2o9eNiMIMtTPx2FOyRVEQHJYwOVZjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G30jz9TcEEL4Tg026vvMUjRvjEFlRtshuuw2scaJ1dbT1hALTwsd5xxTVuxNFQ+aHMqSvL/CC0bjBPjVpP1uNPE9OElvBNpaZ/RMWIzBBUOqbdOV76ol2XYtaNQ6As2j2CsMkJE/o5rc0b0opUEqTNsFLW63jXTSP4+ME84CZXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=fail (1024-bit key) header.d=amd.com header.i=@amd.com header.b=374d7ZrN reason="signature verification failed"; arc=fail smtp.client-ip=40.107.220.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jo+4lBKqBNizzTqHgtYVNprspVG0Bfw9hENR/5PddylxdH7VFKyLYz9htErZZLTbRrKKAON6aJ8XlRT8eR/uCQKcldrf/Vh617oSX6gYrQnibgBW2AAjMrSPCNEivcGWEdK527GgE8yPwZ0E4P4syHu/DNGMKMRJwRZrPsML/b7G6HyClv43UmeshX7ovKo+9doaYG6uTZxDmKaZiS4OU0pV3TFkUblsOLZjpckVZWc6tQtU8HR20F+zdk2ZN9DG2U3czbi0N2mUfzivcwsT9Mx+Y8wqoc+3Olzb1SaoiyqgX7WsdN3Y1bYPe5PToLjcXUQhRojEx9BULOii3nkfaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYKzFgBaE+Uf2xRIjq09KnbCyUDmuIA3klaqjnb/xfY=;
 b=f4ocNVO+Sv8dykfOLAxPg+TYLjPtTYM0InZWr9fPZzp4+X4yX56x+pCveQ+wwtRO2cF9r70f758NlRPbIdpG2Siy4+hPO42sS0HdMZpTUkPl0/34k+do6rxEA/gPkRllfdbUSztOynrzikmArrBnLI8pHS8nJk28VLqZNtd87ppz+27JQBzWuXLrEzkFmKP2OeSQrtNnSofaXHw8EsY8/WXyiE1hxdnNNdpE1AUIJMF971HD1Or+p9EbmEVk1BNIxq6EXpjQMYZhojfLV6AcL2+NeUbTWRJO2bf9BNUy4m8Jm1Gug6UB/ShqUmGl5GgFPqOh+S8Bsn6reGADVcuCCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYKzFgBaE+Uf2xRIjq09KnbCyUDmuIA3klaqjnb/xfY=;
 b=374d7ZrN2YXwn6YfFf458/Gs7tJSxBrG2T3exx6+UnaH0ZRaIj6hDLGGT/cDbsU8Vm9aXcnAH94MVkzMuhI5xgxdl3nwE4S6XCncWgDCKmlprXqzOpvVf6+KEboPNvTRafa1Q8vMz6d2ELaXufYpRUwP25A0OpxptiMpG50BhdE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 PH0PR12MB8127.namprd12.prod.outlook.com (2603:10b6:510:292::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.27; Thu, 31 Oct 2024 15:34:49 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%5]) with mapi id 15.20.8114.015; Thu, 31 Oct 2024
 15:34:49 +0000
Date: Thu, 31 Oct 2024 11:34:44 -0400
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Luck, Tony" <tony.luck@intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
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
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
	"naveenkrishna.chatradhi@amd.com" <naveenkrishna.chatradhi@amd.com>,
	"carlos.bilbao.osdev@gmail.com" <carlos.bilbao.osdev@gmail.com>
Subject: Re: [PATCH 06/16] x86/amd_nb: Simplify root device search
Message-ID: <20241031153444.GB1511886@yaz-khff2.amd.com>
References: <20241023172150.659002-1-yazen.ghannam@amd.com>
 <20241023172150.659002-7-yazen.ghannam@amd.com>
 <CY8PR11MB7134D716377B0C5E40E5C8FF89552@CY8PR11MB7134.namprd11.prod.outlook.com>
 <77c96d66-02b9-965d-4c43-c588aedd1d48@linux.intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <77c96d66-02b9-965d-4c43-c588aedd1d48@linux.intel.com>
X-ClientProxiedBy: BLAPR03CA0041.namprd03.prod.outlook.com
 (2603:10b6:208:32d::16) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|PH0PR12MB8127:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a60c241-084d-4f45-ca99-08dcf9c18e6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?2ACLZHofS4JE+VbsxckeHTGmSlY42sqyXkyfIsU8PAaXUfog3LR2y6vtpD?=
 =?iso-8859-1?Q?vw324mJMuonIt0bS+6YQ3CX5rucJK7OjCXLgQFaC3dqXnUe4Z64FHaRZx7?=
 =?iso-8859-1?Q?4hPDURC7CxH9JmmNuVAcggNCfmsspu/k9H5omwYOwe2keY/DHCtmbD+KKk?=
 =?iso-8859-1?Q?Q/ZhS1DvRaN62nbN7uKuvRoIUc4/OZ64Rw9cOU8/js8IlT6mcLBLkvgRAY?=
 =?iso-8859-1?Q?fp6LqGsPHOIo54oJmccxp6HcYJM/YAJvgPWp8gTudMLiLIUDEg/mtlR/Hq?=
 =?iso-8859-1?Q?1AuDKcxm++1G+h7tAYP1Ue5wferbuYZuFh3f5Ng701CdXmPWkm6Cg8PNNs?=
 =?iso-8859-1?Q?UA+YMZ0B6fw86yxNzx5ZaVfK9VoOWUTWO7cGm2LYH7CmsUa0FK1VMPftZi?=
 =?iso-8859-1?Q?XtOcaDsGzKXR+bKzHRv9kWiNcFgmnYSIdQ2mMgliaLdHqzGrhYOced7/p5?=
 =?iso-8859-1?Q?GsplY/I1uV8FM6AG0S22vVjB5vwWMuAvlAUZ4ygRILmtHl6C2zkT21VfUL?=
 =?iso-8859-1?Q?gByWFWzoU3LxQpLsfPRKw/Zot2D5ffZLCFinsugOm25GOT96GMEdNQQ0HX?=
 =?iso-8859-1?Q?zcB3xqCq2fyVfELsCz4dlEWGmJ6MhKZ64DsQ8YDAUdB4WrCHIQUkkIMoXE?=
 =?iso-8859-1?Q?+UwwTjnv3I6twqtOjy48vpRZ8zQ8gxJeYWGHQDYV9ec+dJVKEPptXca9kB?=
 =?iso-8859-1?Q?jRV/qbN1nCDwPpOYB4rN2RgrKTlNZu9DBPFIfv7fLv5msbCbE+ICgSx0pr?=
 =?iso-8859-1?Q?InSdeX3hmG+vP5Y2c5xIdhNa8mbLOsqIihLEqMuO7Oflyy3VkbVfP0AIlJ?=
 =?iso-8859-1?Q?DojLXgzFVYQID7ayIQ71MRU1VV5hddsOpHR2P01y8SWmkXouAv3s5MxS0s?=
 =?iso-8859-1?Q?I3Y3AAd4HGGW6hQvDuYd+4vJU6Vdm6j/tD471xqDvx2aUzI2FIYSytMMfB?=
 =?iso-8859-1?Q?/nfXEFtaLUTq9WXvrYtSMkx44B7Q/d/pppt+WOINtOKP9JEarGTtuGW34v?=
 =?iso-8859-1?Q?NvvHII2xk6NGpepfRKIo+rH7sniFOJLOyDY4k7ugVmO+31uavEGvM4o7jh?=
 =?iso-8859-1?Q?MnwDbihr6DXRxj53dWkNIiVu8jwcWRDP8UsRgt9c78sNEPXHdfPYuo8JA/?=
 =?iso-8859-1?Q?Dxl+O7ows2cZICTPJKunWYqJEi9h/CQcq6ehq+8uPCkyx502Zie0K6Em/5?=
 =?iso-8859-1?Q?bgWmFy0hpGw1BPGMWjYazfxewkK+Ptqn9XDe8x9aX99bdS36glwxkBRGMZ?=
 =?iso-8859-1?Q?Jor33zNBfNSgVA40npbS6rLGmLDFRfYplk9znORt76BPyIY7Jn+BR0WvM+?=
 =?iso-8859-1?Q?aUWWiPd6cFRbT0gbirCV8bYi4L5oni0bwY8S0i9ZPM1LQkc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?M79+8ZhmfZlWirjDFiQJe4ATg96bxb/4QUqIX27k4df0FKTOL29y2FhTuj?=
 =?iso-8859-1?Q?UHDOvZRfB9/PINVgkZiIJnkKbCbXW/WB3AzvFafQ99kiYJeLvEbrY1C6zs?=
 =?iso-8859-1?Q?fPQC4fssaPouz6MmREga6XCt4bRwD1imQcvkycATHRSdmVNchPMLYuT2G3?=
 =?iso-8859-1?Q?ubRfqQYcMih2hQAsXFXkJneS5Uib++btsjJqKTDnzfWhrwps6ffdFf0i8N?=
 =?iso-8859-1?Q?d+Vv+DqUM7PbK9irjBRIgpog0AmH/Sw5vc0zDmYLhus1TqrNal3lofuFzm?=
 =?iso-8859-1?Q?jg8W+hjQuyaiesoGLDlRicTsog2+ptvrGvzY82B2poCjK6SX4GpBzsZks+?=
 =?iso-8859-1?Q?EPM2NHHUiwPjgTuRYDID/T74cD2pdxHV44yJXWInj6zvYuygF09DVikKd+?=
 =?iso-8859-1?Q?Jkm0J4/UA6EtH6/iXUIvOOzEdU2ZAFljSVp3vcrMsOXWq3wPZAoeil9Rz2?=
 =?iso-8859-1?Q?htofohHopcEkF+r7DWPh4EyY9zOt68sa59OWjRINh7damQ0SZXX+pjjfYD?=
 =?iso-8859-1?Q?b36BYchs+txyCtQCubWtZsumj1EacwiZTRWsopnDrQgHwAbolpFRnRK4gD?=
 =?iso-8859-1?Q?4UnR2FEvKBhG6p5O4DGSd/sh/dlJN+ZN/vV/v8zJgnlarqTAX8kFIvTPbc?=
 =?iso-8859-1?Q?arHjrhhfRJsvLYLg9c7tEZoWypChnjZrFhDQED9i2Nq9L1NJfIGVfIDA/J?=
 =?iso-8859-1?Q?BrtK2L52XtVdqSVla5ZhKU7z+2zA1l0jia+bVQkTUSfRXVkbF/THDO/5Ci?=
 =?iso-8859-1?Q?s49IGL8XEjDw+5hPCvIj20wuzwMawg7nJjqHIcbXWLW+9biw0mdBPa/EbS?=
 =?iso-8859-1?Q?4xbbhXmOXKXHAFHBpsQXGhi3SDZ2rs8icw3j+k0ydbBGlbADQYD2Zmivty?=
 =?iso-8859-1?Q?kKeTaq/lbB5/lSI+KKXfQOnO5zWy9Y29nZPq+EKspw4YzLINNcXUWAnxkM?=
 =?iso-8859-1?Q?Xm2PnJ4kAf3kIwfiTrD0Pzjc4HGpbRaDQ9GMso4CU6hGqb+V3dxwZYH/xk?=
 =?iso-8859-1?Q?xT2/sd4JgVm85/nu4TZ72aQ+q3sEllug1RKUTqjfdv/Ae5OIz3DxHTL0Ho?=
 =?iso-8859-1?Q?jTrkph3Ytq3NdAd7cPPwrKKlPBvZzqm5B/LWu8CeRaX4AOqg4xZaKJb+dJ?=
 =?iso-8859-1?Q?Uh9/woorNe4V5tucrtlCXSwMIbYwdvG7rkwBRf91tlZJbPpqUcGH+mojtV?=
 =?iso-8859-1?Q?BISWmS8FP1dK+auRetg0GL/zguLUvFBBR1rRvYmNU62WTrXJKG0eYJJPyn?=
 =?iso-8859-1?Q?fVf0mSOFcyPIah/mkkOnpnLho6eXfrGXIowTgY3wvpEyvpGiTocHTzun90?=
 =?iso-8859-1?Q?0SoBumbH/FPbN9oONXkivfbuXxqaJtifkSWB+SqKqwYI4V1u9HmEDu6dKk?=
 =?iso-8859-1?Q?a4x+f2M0/FqlseSD8vlpAXjfkYRiHg5hj3uh+oN2paVuWS2ouSwxmOUdEe?=
 =?iso-8859-1?Q?57H/vaxRQDr7Pgm57H+gXaYAJtqDqkT+ifBvmEHZvRjCeWHO0Fmo6TNaWH?=
 =?iso-8859-1?Q?OlRH8XekA2VsnhEmiE/1dslFlv6fGf2z6uWGIUgTcOUozR6YZYvjZxSiCA?=
 =?iso-8859-1?Q?WWLjqum936RQP1ofGNMdwWDaA2NYeVx+5RSWsYUbQZSTcq75OFtVTCralk?=
 =?iso-8859-1?Q?sG2c8MZYzFXTcFeXfZrv0JEzx4wIKLH/Dh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a60c241-084d-4f45-ca99-08dcf9c18e6e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 15:34:49.5956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gcGcn16ye7Tg3K1J1L0V02thHVCNJdEJhY5ymJFYe11WEgLiiHWYlUV2377Bvbj7S/FNVdpVLw++WrLZFQqrPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8127

On Thu, Oct 31, 2024 at 12:08:20PM +0200, Ilpo Järvinen wrote:
> On Thu, 31 Oct 2024, Zhuo, Qiuxu wrote:
> 
> > > From: Yazen Ghannam <yazen.ghannam@amd.com>
> > > [...]
> > > +struct pci_dev *amd_node_get_root(u16 node) {
> > > +	struct pci_dev *df_f0 __free(pci_dev_put) = NULL;
> > 
> > NULL pointer initialization is not necessary.
> 
> It is, because __free() is used...
> 
> > > +	struct pci_dev *root;
> > > +	u16 cntl_off;
> > > +	u8 bus;
> > > +
> > > +	if (!boot_cpu_has(X86_FEATURE_ZEN))
> > > +		return NULL;
> 
> ...This would try to free() whatever garbage df_f0 holds...
> 
> > > +	/*
> > > +	 * D18F0xXXX [Config Address Control] (DF::CfgAddressCntl)
> > > +	 * Bits [7:0] (SecBusNum) holds the bus number of the root device for
> > > +	 * this Data Fabric instance. The segment, device, and function will be
> > > 0.
> > > +	 */
> > > +	df_f0 = amd_node_get_func(node, 0);
> 
> ...However, the recommended practice when using __free() is this (as 
> documented in include/linux/cleanup.h):
> 
>  * Given that the "__free(...) = NULL" pattern for variables defined at
>  * the top of the function poses this potential interdependency problem
>  * the recommendation is to always define and assign variables in one
>  * statement and not group variable definitions at the top of the
>  * function when __free() is used.
> 
> I know the outcome will look undesirable to some, me included, but 
> there's little that can be done to that because there's no other way for 
> the compiler to infer the order.
> 
> That being said, strictly speaking it isn't causing issue in this function 
> as is but it's still a bad pattern to initialize to = NULL because in 
> other instances it will cause problems. So better to steer away from the
> pattern entirely rather than depend on reviewers noticing the a cleaup 
> ordering problem gets introduced by some later change to the function.
>

I originally read that in the context of using a guard(). But really we
should do like this in any case, correct?

struct pci_dev *df_f0 __free(pci_dev_put) = amd_node_get_func(node, 0);

Thanks,
Yazen

