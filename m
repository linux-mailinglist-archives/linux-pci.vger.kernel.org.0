Return-Path: <linux-pci+bounces-36078-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D74EB55E94
	for <lists+linux-pci@lfdr.de>; Sat, 13 Sep 2025 07:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEC38588497
	for <lists+linux-pci@lfdr.de>; Sat, 13 Sep 2025 05:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3492923CB;
	Sat, 13 Sep 2025 05:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="je0Etj+K";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="JGVwTqx4"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748054A23
	for <linux-pci@vger.kernel.org>; Sat, 13 Sep 2025 05:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757741695; cv=fail; b=IFs7fS72l1M3kUzfcJfRCtFcyob8JX3ZI/Rrg9qqnm7WJ9TTiJVAYwz7DclN8Lu4f+rf8VRgkYyH6nOZYxyDHH8iDnmLr/GxwUOo/jWIWXVzP6IBnRmKuwHT3c392Ff0hw0qvWCihFD8TNWReY1erhnQ+fwHuFXj+S6yTpQyOtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757741695; c=relaxed/simple;
	bh=iReE+MvzLxxltv/0+oZLjSi5anAVgTNGdz0teSVgv0M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=adI64NMRiNYz38eBxHus/Vu3IQrpiOgZ8IRZXxbrxa68ciWbxC3b9nK49/4KJmv05zTqdicJdoZwoYKjpg3T4aDoPBihEsCQZg8nj5qnb5XmesW/eumUWCjcqYzq6FxjJ5kZuaipcvzQGjS4ium86hJiHuXFsYGjZ0eKxnEkazs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=je0Etj+K; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=JGVwTqx4; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757741693; x=1789277693;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=iReE+MvzLxxltv/0+oZLjSi5anAVgTNGdz0teSVgv0M=;
  b=je0Etj+KBPeKb5Eqi9Nf1ij7KMxYCvbC+rZaWaSZe0VeXVfPzyBH5bG4
   gn7sqyNuoC/I688VzpBHLD0Vsha01KnOuP8u87lhcj77NHXF0msCjAmhI
   Cjx9G7K014aJl35a6TSXwLecEdGVaPJNQyqchQWsPQdlb3SHBrWpkhBpD
   D2okz0+S7I8Gy9IYtfI1GsBf2X/1iXl4afMtiRek7Rf/v2uFDdivP77jO
   NxKFIBlZLMYq/F220znz9R6JZpn6h79S4UW0m8rPyk2auhpkmhkge1Wb5
   sdAhu7c7ykVrKhRt8o9eZIFcbt4iwyzmw/PHuNxwGi+dH8aFpLevSi/eB
   w==;
X-CSE-ConnectionGUID: NluyIMp4QNCIc5lvRPwAHg==
X-CSE-MsgGUID: aiGEjhnuTeGkGrOKhw7Z5g==
X-IronPort-AV: E=Sophos;i="6.18,261,1751212800"; 
   d="scan'208";a="120377316"
Received: from mail-northcentralusazon11010053.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.53])
  by ob1.hgst.iphmx.com with ESMTP; 13 Sep 2025 13:34:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uYZj1g/yJ4+IHLVozXimDjGN5mjDwWzVsyka9k2/CoXtz6dyMJJj5IzZaUQ/WgZktGmmZVwQt/KxFW+dE9uAw9r3jWs/gr/1hVf+VgZrUPDRqc7emAnwBFHyk6NZz+XgQl89JU0vpZuIuqrIoM4vEtBQbupHzhpgdHImxNkL4zqAHKBcMteA50IPHjauN9LeNCZEroVyv+vM5vKG1K/KX7JTIWFfWShRGmOghuM0aZWjiJrc98RL0z0cg/ELIxqIMOuoAs0mjTBSjfhDQsjhRLDcuW08JKbJcMg6BE4OsHedLo42TKAkQUatL4rwlT0YILC+NUaL04UqBGkh08a0TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iReE+MvzLxxltv/0+oZLjSi5anAVgTNGdz0teSVgv0M=;
 b=Bhi16j59Zk5M5uxmVkP03v3MUnaTBMBvAbn5nBOWoN2wLofizAOBdh88RMPyY6BZ2QUCfRaM0av0CEV6Z59DIW4iTIVqZwb3LcGJ3tL82wyhli8zTVDJ81auS6AOuZq0r0htYNFtWt2yC2Ijq/1pEOPS0OXF7W5OOE2gDJDFMyLXrlIZt7GhJu7Ap11w7ilLmKE6+tV5bSUW8YU8H2GrfGsnKWdVhEgkfVIYZae3oXAgkdAQcabxgiMQ68QCeRRkXxIKPdqrO/CC6y/e7cRuLPWt8bCUUqSfgP/ouIe7cEkZHgy990dB53U56sZCl9ZA3Wr2vqvnQs8CWvrY9cH1hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iReE+MvzLxxltv/0+oZLjSi5anAVgTNGdz0teSVgv0M=;
 b=JGVwTqx4DcnPVOfdEm2hmeRJDInOVt+M/z4Hawgw+S43DORfXWLa5GOIhDkUfxrVprkgWPw4QNhoKNrbGgD1Q55lhl840KTmaeSl/kOard9jvMMz5OhucqQStBLtQIJBcc+Qo1w8pFs6iIovpFB8vhGt+u2gSF6e2zp5Bs1ZugQ=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by CYYPR04MB8837.namprd04.prod.outlook.com (2603:10b6:930:ca::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Sat, 13 Sep
 2025 05:34:49 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9094.021; Sat, 13 Sep 2025
 05:34:48 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Manivannan Sadhasivam <mani@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	=?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kwilczynski@kernel.org>, Kishon
 Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>, Niklas Cassel <cassel@kernel.org>, Damien Le
 Moal <dlemoal@kernel.org>
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: NULL check dma channels
 before release
Thread-Topic: [PATCH] PCI: endpoint: pci-epf-test: NULL check dma channels
 before release
Thread-Index: AQHcI7SAwz8aUudiCEWNliE/vEGUmbSPxWMAgADTb4A=
Date: Sat, 13 Sep 2025 05:34:48 +0000
Message-ID: <gbbc5w7hn27wb4txtnifyiibdl6y4644jkzepdxnhy7ozejpdt@owqse5pqxrez>
References: <20250912071140.649968-1-shinichiro.kawasaki@wdc.com>
 <hjqei3oc33o7uqnpv5lcxph5jk3fmjbdiuljdkvxtuv7mowwy4@tvljtegx3rop>
In-Reply-To: <hjqei3oc33o7uqnpv5lcxph5jk3fmjbdiuljdkvxtuv7mowwy4@tvljtegx3rop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|CYYPR04MB8837:EE_
x-ms-office365-filtering-correlation-id: 97c02e44-18fb-4c6f-0ec9-08ddf2874154
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?Nd5Ez4qIigaK3eeYa3A5OkjESkTI+BQ9jlldqtRDN8MUoZdW8lxae7wL+t?=
 =?iso-8859-2?Q?Cmlh5k/SL6dPrYLVqsKzgt/E9IURqeg0r2XVER/fsZBgPpjqbzvENpohWj?=
 =?iso-8859-2?Q?DJW+me3PN0laL68EbqUa2hjMW8Q1DB0XM2onZ0Lrijm9jBtf5llYLmkmbD?=
 =?iso-8859-2?Q?uF2UfNb5QAC3mU/lzdmnC3peM4CkfSptedr9bJc0SkQ/C6FlN3q5cOOcNC?=
 =?iso-8859-2?Q?O0vYUZMdRtXj5mPcQsdyvOF0JD5Fs82qdNKj36Dl/fGGq3ey37O8JDpmJV?=
 =?iso-8859-2?Q?9JnI2/WI7o3ToBno8r3JSnIWa8G9KM9s1U5fyQpKBKQh8Vs0RKHAgnd8nd?=
 =?iso-8859-2?Q?lCHOE0AzsdeybVThYo6S0O+PrHDzAm00mxAZr3YdZMSsh5iPFkW3BIMm0x?=
 =?iso-8859-2?Q?YZWoaDjCR9eJs0oE8DdnfVuxFsU5ADLqbK0NNSqQh0qurAHjBkbqBosMJ+?=
 =?iso-8859-2?Q?P7sOS7vfDe9C7d/r3yyMcL27B9djnoNjtclWdnSxIFlGsXzSuvv/Zzn6y0?=
 =?iso-8859-2?Q?MauTMLa3XUpp1/bsJIgzv8wVDzXucXShtO2RrWvQdEuNQMoxnhbsT1pXre?=
 =?iso-8859-2?Q?SPNSA7WHqKE9/RnDPnVNzzZYc2mcNAqRtow/aNlJCKn1/pgS7zpnFOZhR3?=
 =?iso-8859-2?Q?Rn0TGMDkTACkiFSVqU3ign/BQPYU9mqPI0hr0qfR/jsHCGPvZCDZug5VrL?=
 =?iso-8859-2?Q?pSEIO5pzJ+yCpucDRIKL/aqGtNvpfALmEBW+EiHmUE4fb+D5FXXTHGO6DG?=
 =?iso-8859-2?Q?2xgGMTxj/DNzHP9UlRzKK8A8Nuw6JiP4d5y6Twtpeq1wN6Y6sxeWM2hEeE?=
 =?iso-8859-2?Q?OLFBeO2FgtMaS5jvRiRVY+ZTXgGYuVcGgQExCrEjQLWXxpeJVsbAxhK3ZM?=
 =?iso-8859-2?Q?4cW9K6+sxqF6JyE2nRo/Nhjs845FB3SrixzKX5XsazAIZs2xE9H5JVtO3G?=
 =?iso-8859-2?Q?8BHkc3PgtXxxJ+Gjg2xLKwOtkdMLuzUllE5LWgSI2tPXzyKitWc2H0hqhy?=
 =?iso-8859-2?Q?wRGcfkGnBR8vAfEEn/Vhx/jAt/Av6QAt6Gwmm/rjISptHtoTWHosuRaGC7?=
 =?iso-8859-2?Q?43KtPoi6GdD1To8rXaRKC8XBNEzALF+9HQGOSYPG5W6RJFDjCVuVVWmiJx?=
 =?iso-8859-2?Q?F+QZdKlGsf57ntQ0Jo7/4V4alvtoNR2TOXBvR/fzoBmf7czhlVq+Z6dYfH?=
 =?iso-8859-2?Q?xfBrSbaNsoCp1vLCXVVM/z7MTvPM+AjsbRi08Wu0Hk+k5Gs/C3TJMk2PYA?=
 =?iso-8859-2?Q?D77Ex3vspHsDgAcdQOH5tIA+2n+PKrPseU/1EyNbgI70JAn9S51kLA3r9P?=
 =?iso-8859-2?Q?2X7QwCHQTRqmLd23JKxQhuQtFMh/jOcUOeLg2hYEEC3FrZunXrDH0I1N28?=
 =?iso-8859-2?Q?zduhS6cK3nNZIq+hqVJP3aR/5FWTlJ793MztlfGW5/pUOXEjcDzrnLTFos?=
 =?iso-8859-2?Q?OKIew1CPW1nEjLFFOLw25iR+83yTWtyois83dmHVMaKLzeh1kxyRTT/t/C?=
 =?iso-8859-2?Q?p1uCK2/GNYA220RsTVQctBBvtlqiC43W5yFdKk/fxLuJ7I09mWTUvEm/TX?=
 =?iso-8859-2?Q?Ak36g2o=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?al7oOPmlpboOX3zw8qpYB/Os51i6G5Z/7EOCSiNvW/S/m6Ui41t2EHzfw9?=
 =?iso-8859-2?Q?IfBSEPMEVq2AbNyJ7STrsWEqJv0ol5JjD+ehhschQTb7HdOQ7ow+wDgWlE?=
 =?iso-8859-2?Q?KNW7lq+1CuMR8uvOU6x42q6qGG+qKHYtz75MdmlfJvdJa/SUjUeVvyN9Cj?=
 =?iso-8859-2?Q?A1JH3BNBLxuYVEzdvCbkywLtV9+3J1aEdKMbYFp8wwYmy6fJt10BZ12WQ6?=
 =?iso-8859-2?Q?5480392wyo/5VCGnMObP44DPRu4OHRsXYW0Qhzl64RIWT0/+MjutCisJSM?=
 =?iso-8859-2?Q?YXbz9CSE5IexAZ4hyCrzpWcRrOZA7UoE89Mi5RBFo/3qsLhrtn6Cq0noxm?=
 =?iso-8859-2?Q?NGdTr/Rm0DoysRzw12KSWPaS3LLqj2sMh39iDBgQF6dtovbSLgRfjlee2E?=
 =?iso-8859-2?Q?LQl8rd/1Qml/Iy/BQ6/CVZoNk4iZHCSTK70XVHilYZpnAWBPqZaLwW9d8K?=
 =?iso-8859-2?Q?u6zBWUpK947DDRtpPoXdiVtWhTA3MkaHZcm4tABFeRYqJ9XGTrkuaEeeKs?=
 =?iso-8859-2?Q?5UlRmTkEgmwK7uj3eifUhch1s/DZMiDrhxiwdKAK89gE+aU9KwB+R3C7Op?=
 =?iso-8859-2?Q?sL/s+zP6bSjkC6cmUyhcUGm5yuWgjJGGiVCdgXdpzUcvw6enjInd0ojUBV?=
 =?iso-8859-2?Q?pD9BixjSiw8xEwXlVIVHhYC3ag82or9X+F++pYc1fnR7rHukkgt+WrZLgJ?=
 =?iso-8859-2?Q?K63A9tBIWsAOZBhTrFVLULGQTbZHy84brr/BYyUJ9Y625Babas+4UdLdYz?=
 =?iso-8859-2?Q?TqpLQFN6ogaoYEDnsISu3+L52x5jh/7f8W2XS0xy6+c1Keyxd4eszObBlp?=
 =?iso-8859-2?Q?Pz4a7d66Wvr64Axn/7tA7/lQtZKg26v/4wXVNj6WQuQhye97+RrFA1lzaF?=
 =?iso-8859-2?Q?oaWqt4oamN88DfFu89Jye0B6gNrw5VvElG89zT3hFFUnABqxSDjDNByslr?=
 =?iso-8859-2?Q?WKLhimxIbHGtHB0aL/En8r0yaDxJnOqh0z6rVpGh9OB95kHSFxGLNw3vsK?=
 =?iso-8859-2?Q?nyE/ScJqKAaq8yu0f3C4nrJZpZF9jRZ/Sj9Kdp54cXA+koz751nki9w7PS?=
 =?iso-8859-2?Q?q/8dt9nhm/AghbVuqYYQCspvokQRY7LTMnFfcg81WAtvnmQkMl5s/zvyy5?=
 =?iso-8859-2?Q?6xmMx0Potv4IB5/MkkcryoYE0a70GkSavzhxesi6VArM36DHgwfRpszHAq?=
 =?iso-8859-2?Q?S4EoALg1hbEpJCfzE3CUHkwe497ygdis39zGxJkwZpfFxVsYsaAQUIN6oc?=
 =?iso-8859-2?Q?6y5K2nI99zPyeHxOLPpBOc/Ceb9L0nmUWigmOTbUjfpfrYFWF/7dsxYLem?=
 =?iso-8859-2?Q?5d01UK94gQfjl/7jSWFaUhlS41r+YmZK47nX89rqoa+WhrweHOpnEn1d2/?=
 =?iso-8859-2?Q?HE+pWswZrTQQqkgA+ZzWYtZrd8kF3Jut7omNXbdr+bJLWVlchYAbgbR1yR?=
 =?iso-8859-2?Q?/wpxyJ2nnztg03eRQ8yo4T38lpA7eSYTT+L6OXNQwfByKKTXAvS69zy6NS?=
 =?iso-8859-2?Q?8Tj5yYrUKT8ksi8aMwSj0nObXagMugHmEnKuvAGCqBRXMMTji1cgsijKbH?=
 =?iso-8859-2?Q?vC12GaauHJPCy/DYVDXZb2O6UwUGQVgiZm0Qk/vbqD8dtkS8Iwd2aFCKqt?=
 =?iso-8859-2?Q?MiDGlr4RaE5+7YUWg5JqqFCToKq2CBch80QatokxQbR23Kpc+HkvEUujGQ?=
 =?iso-8859-2?Q?QTFxdUGZ27ciLTx3tkU=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <0D10591BD36A7341971DC3C4CA43641C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aWfZqfjDMzGQu1vwLBKiop8u/5SYkqa6NqXxHTypUynNtaXQ0g8XixEJ1Chs0HTbvZvVBKymRy5gnCpfWJF2VmVA6cYlvvbK/xnEhSmXlDPoLk/SKUC5SUiScJJX9Fx/o9BGHamLy2fYv9eU7chI6nwid3U2YgTp5kjD7MKwiW6Vjd6MVWTwapXyFp5W6+VmC0nB7h2vGSvNeNhhaU4HDJIk3oKPKzauz3kTDqwToMIEkzaJjdV+1HF23mObHLlCz3EOURwGpsMPQZ/dw3snJWy8wTR0Ti2341Ib2TtJ2lY1UKIoGzFpEiA1WlzLENPuiCdwRZoHeAdNtwKIjBwvmXvcmS0/ARSBP38G7U1FC3qaZ9cFo6unpGemf5+TcehuGsyNO80jerm6VCa+LSqp9eR3FhxU87u4QOG6YYVLaAT+3lw9ZdNkEwUICtk2W2+pIooj3Syu7PHpuSY5BMR0evvHYA1xVUxBQr6uwKR2sfbB21m2eGUJwMq36sOiqBjme+SICQm/S3Co9cktCmmoHe3aFxP4BRIvURl8uPEp15FQ+FfaNwHHwkLzI5sU/PNU1Jp8w4/PQ1h+ozxFtgEP9gpNp0tEBPPtrHT0I1pT4SfJTIhuFE3dgWvVRyoNsoE9
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c02e44-18fb-4c6f-0ec9-08ddf2874154
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2025 05:34:48.6339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SPejXEMqfCpemWqtv0BgiR38LTgoPzDx5fjXsdgzoZ/mRIqwoR/Y41806xhfXfLq8zfNFoKlL0J4ReAWFltzlGM56k3HmVZADumt6ieoRGI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR04MB8837

On Sep 12, 2025 / 22:28, Manivannan Sadhasivam wrote:
> On Fri, Sep 12, 2025 at 04:11:40PM GMT, Shin'ichiro Kawasaki wrote:
> > When endpoint controller driver is immature, the fields dma_chan_tx and
> > dma_chan_rx of the struct pci_epf_test could be NULL even after epf
> > initialization. However, pci_epf_test_clean_dma_chan() assumes that the=
y
> > are always non-NULL valid values, and causes kernel panic when the
> > fields are NULL. To avoid the kernel panic, NULL check the fields befor=
e
> > release.
> >=20
>=20
> Have you seen the kernel panic or just predicting it by the code? If you =
have
> seen it, it is better to add the logs, Fixes tag and CC stable list. Even=
 if
> not, Fixes tag would be needed since it is a bug fix.

I saw the panic. Will add the kernel message I observed to the commit messa=
ge
as well as Fixes and CC stable tags. Thanks.=

