Return-Path: <linux-pci+bounces-35999-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B21BB5488A
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 11:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00DA5A08237
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 09:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6567227B356;
	Fri, 12 Sep 2025 09:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QADHO9fY";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Z/NhTiiM"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AA9537E9
	for <linux-pci@vger.kernel.org>; Fri, 12 Sep 2025 09:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757671153; cv=fail; b=n2OCe+7+U2/GmZjkR8h/xYtXuMBQ7aIA9HLGIqUY4IRraWf3zZhUG122Bc0ujMJEOJQWTnaUK3vJbPwr9hTifb/pScKbj7fpsftaJMk+1Y6+6G9M1oE3blu4bKWYyltfy6+OsRIa0UQR93W0UmWnEittuw26IJWdFssuMBDLPKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757671153; c=relaxed/simple;
	bh=PxM0LQBnZKSmakmD/3sq4qgcRhTGK+kxvCeXkPMn5/4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lwCcoD4v5BD9tkDWw7ZmBxrWkWtbcAyHwX8YuPrin3J9kD62wSlcgepmHnKZcXKjJjAiggxdN7TYrXUwpuyilS3RBCpI+YObkNFCo5gczd3uLpiD8oIfg5kDKqkAn2CRsJ3A9yRFJST2z0PAwhM4s4Dm3yK3MKk/ZFY+lM6EcaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=QADHO9fY; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Z/NhTiiM; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757671151; x=1789207151;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PxM0LQBnZKSmakmD/3sq4qgcRhTGK+kxvCeXkPMn5/4=;
  b=QADHO9fYLaKzGdDMaSMB1QAFxZ3wt0cZEq4dpkVyT8NF8fKrGhCQS8AE
   NBeFG8ZxWHtx8GJlM36gGwp3cKL0LhkUo3DxzXmHw3uidxg/zQxtvIbIJ
   /oXnayBNYI8tlZSnXcdHJ2gxY/ftsoAf4x91iMIekKpCvLyEkOR0LjrKy
   6BBw15qDIB1Uu7zd3syuIJdgFEIADpIn5IRA8CJ0UMy3MkVVe7RbdX22s
   +zIg/KRPWkpXZlREdFGAPA9oj831CCnA3/ReQ6HxjFiMFt8rNHB9C6doM
   vRNKJcZvaaYeNZIKSL4teWTC5gnLvyC0l2XHw+Xj/WdII3JQcEsgCpHbI
   A==;
X-CSE-ConnectionGUID: 0DiENIvqQbefeotFWiDIHA==
X-CSE-MsgGUID: BDYTUdE0TZqJvDK0DugM8w==
X-IronPort-AV: E=Sophos;i="6.18,259,1751212800"; 
   d="scan'208";a="119632803"
Received: from mail-eastus2azon11011003.outbound.protection.outlook.com (HELO BN8PR05CU002.outbound.protection.outlook.com) ([52.101.57.3])
  by ob1.hgst.iphmx.com with ESMTP; 12 Sep 2025 17:59:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mr8p4t/8zhcVG8slgUxGIkwK/QQLoy2QGQQcVJNs1VhuSG+8Bd4DwoUofBrStcyvRcke3yuDkCrVl7CcDnhn8axHdB/y3UcI/Lsode6KrCMpC4Xw1VoJHui1e2adie3Hkq3z5HdF1jEnkHf++kqYxQiLR0zXug/5LYw+PDxNCoVkUybx8RBLeqtCN7f+qrMZMyTKE2ajIrk0vlfBAgC+HkWuExPr5AUEFuqp1NcYWdt05JaqW6t8oHN7ou9e1i6D/0q9jqw+wfPGGmHNhpUBxoK4Udgvq4s8HWFi3yCahGAhAFF3+3vEvefW1Vw7EqBjMuYcHGUfEX5pTW0250WZrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yrn5wO5oNitqwIcdnlG8CZweposTDyxthCuwmqv5KIQ=;
 b=zHRFrDcyJUNrAn8SETLOTtAcGKTjgu7rA98lHTTEDsdDiEXA7/f9C2JGxGAT6VrRzwSUfdiJ8QVFuezVlxuPkS1BfOrpc5ijbDn3Hxlh/qyRFg2hp/cQEEtV4dNpaEF8Eieln266dsZL6Brjw8IcCFjBxwJfjel9hsmHlPQfiZC32M4RIPcv86U1jwC3E8TjSGfjYosWoLiHsZTo1Pm5GDoZHtJj9KDbvE1p4Bg5j8gAZpOKI2q8MmXznz6CBUn6wL81Htg0hbAZXG6f3NoJsNbDpUeHb0gcKg2YNGSnEQ/FrpBAWgsT8bZcfs3jn89vkN9cqG+1TO0aQHg/pkW8AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yrn5wO5oNitqwIcdnlG8CZweposTDyxthCuwmqv5KIQ=;
 b=Z/NhTiiMPZzoGQxpM37ZqRiImqYnmHXLNGcGvlOPor6lt7sxQeGc4fZssrLuL9RWFH5IMhLLPAAFASh/L/Fr3lZygb6tSNyHGA1Jfx6xgiJcOsEAS/pOZJIEJruHeW1GOFF3juaowrNvsuaSfBgXpCsMnXznXFBsQFmr9HFKgyA=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by CO6PR04MB8393.namprd04.prod.outlook.com (2603:10b6:303:14c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 09:59:02 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 09:59:01 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Manivannan
 Sadhasivam <mani@kernel.org>, =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?=
	<kwilczynski@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn
 Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>, Niklas Cassel
	<cassel@kernel.org>
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: NULL check dma channels
 before release
Thread-Topic: [PATCH] PCI: endpoint: pci-epf-test: NULL check dma channels
 before release
Thread-Index: AQHcI7SAwz8aUudiCEWNliE/vEGUmbSPJyEAgAApLwA=
Date: Fri, 12 Sep 2025 09:59:01 +0000
Message-ID: <juziivdtvq4lcpugrw6whe7leq324cqspncd2ivojzp3bvm5l7@lhmdfj3lkjob>
References: <20250912071140.649968-1-shinichiro.kawasaki@wdc.com>
 <94e8dbce-9e9a-4fe7-b33c-1d451c07eba6@kernel.org>
In-Reply-To: <94e8dbce-9e9a-4fe7-b33c-1d451c07eba6@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|CO6PR04MB8393:EE_
x-ms-office365-filtering-correlation-id: 4816c05e-7a91-4971-c496-08ddf1e30008
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?vS4bRXhaJjfyq4IaKCwIX4+dXKhLTV4Z/sTV5f0CWpyUBEECvyco8oHYWY?=
 =?iso-8859-2?Q?Ej3VguxV2AuqBRl+7KsmpENzVYeOVTiDsKx+e8Y50fNZjqTDK9HOb4I1Ks?=
 =?iso-8859-2?Q?c9gKlSwHbfieq9VkZ/ikd1NO5EWU0g5R+9oN5TxiP6OQSt78GOfyPAlbK/?=
 =?iso-8859-2?Q?5M9nFxvgi/mGNNpB8kv+ikiZzgYKzRlQuOiFT6z/0EGl4vvMuK9kS5chRz?=
 =?iso-8859-2?Q?boUfKGcrEez5JoiIagsZVAD90ve0+iHuFQP6r86qQYPGYYcGo7a3k/7A+q?=
 =?iso-8859-2?Q?TUPWCJegfd9qSr+ZlTqoRX7LVVdMTB9+sQHn8LpCTkSXdoQyWhB7ffiEGC?=
 =?iso-8859-2?Q?1uYJTkN8ZPbEkXCknbdHmDEI+tGesmfl9durpV+gWveLNVA0Und8JslNQE?=
 =?iso-8859-2?Q?H+j4EUyU/9QNCwydFwEfw1hVJjUdTPxXfHfEeC8PtAwq/bmXAiRDe4PJ/w?=
 =?iso-8859-2?Q?HNBqQ5IWYXRIx2SSPYolTRxx5sm6mTFxBPA9m5vD9neQ9ChfnnqxGPNT9r?=
 =?iso-8859-2?Q?PWNVKaoIybqjmU0ykpH4jmjpt7P3XwnunHyc6hiXyqG/Ue1KRzt4zS6NwE?=
 =?iso-8859-2?Q?2zm+3m0NkKxygG1/Tml/M7cGldQaDJHUAeJx+mlOhqUUns+97ygcmOVBGT?=
 =?iso-8859-2?Q?P+EG7TkwsiGA80Sxl6fADoUUkdaVtjsTK8apvpjb/5DD/ZGJ40ueQjtCeg?=
 =?iso-8859-2?Q?DL5uc8L3PNKN5MZ39Hy2gatiw86S9CejCiDXwpqCZW57caHtXazMR+cl6T?=
 =?iso-8859-2?Q?maqKH67zFJQ1bnjLb5p+P9BmyK7wCSapxbIK+ESHsCU837g1HeF4bO/Bvw?=
 =?iso-8859-2?Q?9E97PcpJLEuRBpaVWrqyB9DFtqSxKsq4p04+d0E0x4I6Rwv6o+93zxGc4R?=
 =?iso-8859-2?Q?+P5+R5vght6tr1va3cpgQbdYfFgDNpSplyGkQRmWIYwQ+g3Pd12OthvrEr?=
 =?iso-8859-2?Q?ZFbVvM/YrAXNC0o45Fy//10Rjag4kzLQWoPuvE0B2+BK7WVK+rYVHCQjQC?=
 =?iso-8859-2?Q?+akVbtaou7fm/UJhgIwsqkdsQnbBrRPuCKGWP8YAy5RKfpiF1A49LQ/xWA?=
 =?iso-8859-2?Q?umuP4Dj0EdOQ6opCrSW78paTVxXQb9pOOYuSgbUR4+LGCz1Cs5Lo+0aETc?=
 =?iso-8859-2?Q?U2OdpWTELBCH7ozS4Ke8LEYGYj9Ln4dWm71FCKrMoJzN5AETMuuGGASHEJ?=
 =?iso-8859-2?Q?2+zNGp3+JE4bff4SFvjo5kDCdN0WpUOSqn9HWyHox0PCOq8gKZR+jP6L4k?=
 =?iso-8859-2?Q?6K6b0DQGCPRAnHjwrQw2+Kk/nKHxodsNXMjb0SkICO2bplRjPJ/hqX1ME4?=
 =?iso-8859-2?Q?euTOUDVPGQj5jK/7hWl+435T5Vnp2TLdlJyWZ1VutT3ym9KrUQuimcHH9v?=
 =?iso-8859-2?Q?h3vuBwvCdfF8CjThB/x8ZpNSEkNtl1GIw5JqZjvljansZLQfUvARzgjl4F?=
 =?iso-8859-2?Q?Cd4BfRNdIZztZoSz1WyBasJs0/Ko5caLVQA6hD/icxOvOWLG/9e2DMFEqn?=
 =?iso-8859-2?Q?bdUvMAYF1M3CtF2Vtlg+NGajK25jzy9QUjL0Y+dNaaJU3TIfvHpRHn6S3i?=
 =?iso-8859-2?Q?JOGcsAs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?0OhPP7dcl2H4lSLeNOTziMCX8rkmXFTOH4lSYwhOkYPC9wfqyA32P20wMU?=
 =?iso-8859-2?Q?okHiwNC5OC/ySFcCWxGVoQQ4cx3soH3dOiqQoXsAWH28/TezZRpVBHByZc?=
 =?iso-8859-2?Q?PpkHPrE5MnwEALfGuIm7+h8MnB8F1DAc7QJJ7ht0CUm9Kq/PDdtNZ1/Dnr?=
 =?iso-8859-2?Q?0jKaVfKwB7IscSbBPEngcZxxnxhtt8fqFlO5JQc92vJJ1LR5T658fdCK7m?=
 =?iso-8859-2?Q?XrjksLaeLqx9B0H6HVegSRvtiQTkx/x/8s/EriKacNfcQ4RVNidvsOeZac?=
 =?iso-8859-2?Q?Jn2yoU4XobusmaAxYLR7pzgqw2f8FaGqSY7O1ANP8D5kOc5Q+Y+TA31DBp?=
 =?iso-8859-2?Q?EbFCTw2CANb589OWh7qduYr2WOOvjqxL6Hx6HyTuNs1QRdheTL+6vjwJRl?=
 =?iso-8859-2?Q?bApxxKpIIocbLa2bIhzVsIg8FsxyAiEj5YV6+nfivKPhlsmi0mr25SSxs4?=
 =?iso-8859-2?Q?NywhO4/SC9I0mrlrxfnj8tJR985r8pIqb19KCJFhSVpe+SCrWHsXaDEIkm?=
 =?iso-8859-2?Q?tk1+cjF2GMiXw3fEBTXQbfvPIZHPGJpp2KG4z+MFvOWFXBCPBatllF2IRh?=
 =?iso-8859-2?Q?s/an48lWApFQME4OcXUHVUPsQTwM+q4Lf0V+DXidCUdiuUweEADh0TJE2j?=
 =?iso-8859-2?Q?uKPEmD+fkC3i54X9CVfvfyx3l1eROH66kKmQqjD1ixFhFqxv1fdoQgtjxM?=
 =?iso-8859-2?Q?Gn/oOf1R62e/c3vjMFF1gAJPQN3BiELVEvQMIYvy0ryS9IXDtYXRAII2bE?=
 =?iso-8859-2?Q?QZEzhHP/0/kmffxqezqRG8EqHQnuWL/9BpvF8y+dDH1AIT6FS2l0m+8Z9A?=
 =?iso-8859-2?Q?FYPsz2hdJT34e2aGXDck+NrY2sW3XTAM/quJ/fm+Tw+0hfM8bzlQ/LyEmh?=
 =?iso-8859-2?Q?HoA7mpcYCNsCI39DbSL+h0geQbQnN6xmTJBOZRfiaNjJH1ctsqffRuE+zP?=
 =?iso-8859-2?Q?aXY1LzBZVH6lrFXy1Fj9/c5Q32KnNvm99eU/QBa6SONjLAr89HTrJ1MGfZ?=
 =?iso-8859-2?Q?Z7gPLyirr+0IbiW8eUxyds5RhrbH4BiE9WUMhDULRzfVEp0aerdcvSxIGs?=
 =?iso-8859-2?Q?TWJyNTgwQ9NmabWQ7datJYQbg0p+SGM/IP+sPj65Q6Zcb2NF5klB3oR5C+?=
 =?iso-8859-2?Q?oKR50EawivXh3rcU+QgVFjzG2NcWbStSkymScB0fNpEOSi1fO7vTXIBcEI?=
 =?iso-8859-2?Q?Xas5eh8AKqRm0eVu7qMtl21e5i7yhbZpL0zRZu/QrA21c7bYrkapkAyVfT?=
 =?iso-8859-2?Q?n1EQY2CsT5HwlxX4FkhlR9aZq5jMQMDk6PZ+SnWMrV0Jw98mRIPm3mOuh2?=
 =?iso-8859-2?Q?DTyAwraOJw8hZ2lxjfpt5C4x0P4WAjWMTzEa7Ck5Udu3eRZoOGCJrmYsfj?=
 =?iso-8859-2?Q?YwIY/NnGD+1oDBudp1108Ez1FOFOE+bA18/o/jK/XMD6cq+CR50KCa7QH3?=
 =?iso-8859-2?Q?qtxSPLwS7WDz2qyP4R+ZgmEImfznKv+rmAEcBwjtOystTXBjqtC1YmiCNT?=
 =?iso-8859-2?Q?LuM3Z4MyUGJipTP63IJ6WSiDQhSC8SwmspLs82LIn77/Ucvf+C486ywL8N?=
 =?iso-8859-2?Q?h2TzF5Ed0Fe3c9kuqzFyt6I4RZqhIv1YfZ0BGCTIpgWeSIulGoj8s8tjh8?=
 =?iso-8859-2?Q?1/+tXDZ5vbmXYAvxNbpgD2OJZAQ3ddAENW/Ns38gD+MZM6tW6l98uT9w?=
 =?iso-8859-2?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <36E3936EC8A7D8458AB7AEE44412831E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5Lgjcjxn1nrcy2/na8bkKtQkf1FhuZcLvgxSFOryMwiuhFeUlZA/QnFkfym+ZTNunlAOP++A+xd3ML5mP/UCtzixoRwL6ApnrjnVSE/ayCFj5raM1vRn+A8yR3jzYVxkRTW5/3TWGS+ZazMPdOgVV3zNsrNb8opgHbCzD/190mY+zTESwlyBwQVibTp1VnX+wVSlgT6+7LkvwRGTKHaFeLKPFgyOG49+sX7nz5Ldn4PvwwVjX0C7n13mPS4qS76HiK0CtqcxFHKT2Tfs7u+KfH4qX7vIQVgVUxmtdxyNpN+z2lvceB5NHcIFaRLFuVl+LOwrJEVer9fj2snvsYekH0cCKLn7oYlYmwReCsqlCdogOckxzWnnFr9lM6oAai3APs5v5lIsyDikYpHDNcxSlDaZqIZwwiAZ3ai0PmZ429Rg4bWB88pYsKIPVUSEA6aEDsZfgh3yVHp4cE5OQH+0pc3VvBDvwOj3F2OwFcepgqEI1WVtkL/IljmsNyY/sKeUu1yepUB2m3HArQ1pKo3G/T0l91aN28Z8+7CpFLcWCEm240WGRKlVaW4V/aD6CEjaCe97Hrzhm/cQCrPGgdv3VLUjwiyy0NanNSPz/oL9+2Wppi2nqpeVgV9UgMaVjsza
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4816c05e-7a91-4971-c496-08ddf1e30008
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2025 09:59:01.6782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /6QCVISKhcEvIXaccJWB04mMYt/9XpxpZyEsjYF5r/GWt1VbTt5WWaYJ8I84myNALm+ng+B2sJdthDgKl7y8HusordaLldyMoWZHivAV/ps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB8393

On Sep 12, 2025 / 16:31, Damien Le Moal wrote:
> On 9/12/25 16:11, Shin'ichiro Kawasaki wrote:
> > When endpoint controller driver is immature, the fields dma_chan_tx and
> > dma_chan_rx of the struct pci_epf_test could be NULL even after epf
> > initialization. However, pci_epf_test_clean_dma_chan() assumes that the=
y
> > are always non-NULL valid values, and causes kernel panic when the
> > fields are NULL. To avoid the kernel panic, NULL check the fields befor=
e
> > release.
> >=20
> > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-test.c | 17 +++++++++++------
> >  1 file changed, 11 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pc=
i/endpoint/functions/pci-epf-test.c
> > index e091193bd8a8..1c29d5dd4382 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > @@ -301,15 +301,20 @@ static void pci_epf_test_clean_dma_chan(struct pc=
i_epf_test *epf_test)
> >  	if (!epf_test->dma_supported)
> >  		return;
> > =20
> > -	dma_release_channel(epf_test->dma_chan_tx);
> > -	if (epf_test->dma_chan_tx =3D=3D epf_test->dma_chan_rx) {
> > +	if (epf_test->dma_chan_tx) {
> > +		dma_release_channel(epf_test->dma_chan_tx);
> > +		if (epf_test->dma_chan_tx =3D=3D epf_test->dma_chan_rx) {
> > +			epf_test->dma_chan_tx =3D NULL;
> > +			epf_test->dma_chan_rx =3D NULL;
> > +			return;
> > +		}
> >  		epf_test->dma_chan_tx =3D NULL;
> > -		epf_test->dma_chan_rx =3D NULL;
> > -		return;
> >  	}
>=20
> Can we simplify here ?

I'm afraid, no,

>=20
> 	if (epf_test->dma_chan_tx) {
> 		dma_release_channel(epf_test->dma_chan_tx);
> 		epf_test->dma_chan_tx =3D NULL;

because the line above affects the comparison below.

> 		if (epf_test->dma_chan_tx =3D=3D epf_test->dma_chan_rx) {
> 			epf_test->dma_chan_rx =3D NULL;
> 			return;
> 		}
> 	}
>=20
> > =20
> > -	dma_release_channel(epf_test->dma_chan_rx);
> > -	epf_test->dma_chan_rx =3D NULL;
> > +	if (epf_test->dma_chan_rx) {
> > +		dma_release_channel(epf_test->dma_chan_rx);
> > +		epf_test->dma_chan_rx =3D NULL;
> > +	}
> >  }
> > =20
> >  static void pci_epf_test_print_rate(struct pci_epf_test *epf_test,
>=20
>=20
> --=20
> Damien Le Moal
> Western Digital Research=

