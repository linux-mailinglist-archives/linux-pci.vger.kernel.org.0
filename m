Return-Path: <linux-pci+bounces-25782-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83685A87695
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 05:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7608188E07C
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 03:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5876199FD0;
	Mon, 14 Apr 2025 03:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="A7WYQWOZ";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Uzkho3XR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D19664C6;
	Mon, 14 Apr 2025 03:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.86.201.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744602787; cv=fail; b=k1gOpw/tOS8VaCLPuospe/Za1L6CEsLgtCK2IeA3G1UFspDPM2yMy4C2ejtB9/UjIYmAr4o7SK8ruJealkqs8BGYnoKNUGdvErMv8PfcWPPCTwYDThAnbiXRgAj47YiqEEr7JTEDB0XSOsv7N0EB3hi7XByaw01Y99CQNeUkKqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744602787; c=relaxed/simple;
	bh=TiII6N1g/nv6oO5fV9egUZ5HnqScB7HOVND11pSkaCA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ssguxuRMPyYTt7iREhI0i6MISGtkUJMM3fA8/pwMXH1d+WzQ7IY5hgTVjOkbORSmM6jaa4sIEtaQbFzmQGVYvPTMbxs41HJBkstGxFCL1wDTCoZ8dFzoRc/gFZVuTNbUquK2lyccMk+qov01l+2F/8d6hR1a6NcKZQmdVAOLSOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=A7WYQWOZ; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=Uzkho3XR; arc=fail smtp.client-ip=208.86.201.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53DKoJW5031004;
	Sun, 13 Apr 2025 20:52:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=KOpl60+mbKrUmb1DlwIiI8EBVpFOJeIpz0tcsrlsRcE=; b=A7WYQWOZcl5Q
	EkMnFs0A8EDMrIEAJ3CNMg/kZItfgfBxYGUqTz4dJOHK54539L018CgoxFsNNJIu
	AL/DDPTRCfYN26CR866W484ZtZZerC1TET5Jl+D6uReLvBAFQMiwz5XULmiAvPoL
	s/tHJoLQf46RvLijSM0dJJ5O0INwhnf/WuttfSxzYqzvCy6+EBMyfaa5t6cUBoDL
	+InP1wF+4qVT2+24tEK3dgAffuB5c/pagSP9xsXqZwKDxHKj8041OEM3qYfyxKTO
	UJDYyt1RVbwhHKa/rUfNfx9nR0vQcP56UW0/meYeCEvYtyI59BW/dbCWq6U3uok6
	y6rLQBIWgw==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazlp17012037.outbound.protection.outlook.com [40.93.6.37])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 45ykry619m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 13 Apr 2025 20:52:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FrQaBgpjHUb9JOvXyUcb/Kj6J7Xk9Q1Dg6ts7uAA9D+cxx/vb3DMS0WvWm+WjbtHXjhQekHouTq5YuZAZ9BPQNCZ3TiaV+wXoZJHVlP6veyVclRwwaIrANsa7ZI9aasLpgwrEgeE1Y2aKpUHoBbFNy6XaRpKf0EPkZ/46ou8mXm38luUZSkZKCElBpF30d7Jth46Nj2In7TC+jcxEL3BXUDgKY9sovRPwvWdiYOnMT9yg4nWSFwZFhwfKMb85QvcloQ+t7/CA+4y0F5Nuk8iD8+KnJ2T7R3VjqZ3DmatYA7phOHLpy7Cb7XhYYPpD+9qXN6XrSYZHh54MX99NWq9Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KOpl60+mbKrUmb1DlwIiI8EBVpFOJeIpz0tcsrlsRcE=;
 b=jjQj4TGS4yQCT5vzsIIdX0v78VrNEYXISdKeeA/pFjkSOnGVzo0hKnUv7K173Gs1IhK8P24MRaUk3TaIgj7ur4U9lPhsJ7fYmwkxRF7Atl7Bpd+pHlWLNPvSqmlxLnL7QAmIbCLR7jyJCaPSU3ZOdMoGYqbhIkurImtUlxLFPQWf40h1zmJ+Rmkdxjwi+ap3mFf0H9o1wVFlfIIZYqdvirscSiAwqFHp62m7cg2sNQihxnfesqs70FSFqITn7CMLarhhHg32QRg6VHIZWnR72YUkV2WWs3cr5GDE0oP8ReMqf+XErVh4FfZJQhZRx+coG7aUOQIMxAznjBZzFwepuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KOpl60+mbKrUmb1DlwIiI8EBVpFOJeIpz0tcsrlsRcE=;
 b=Uzkho3XR1bB2/DTWkOi+pEa7eJ1+HtFoeajdB/UdQDc+9TKL6z8SldzyBPsOA3v+2ElNOOEcf3zaOjom8MnJ8Z7BZRieAx6QaILNqmE7NPp91jmnVdhEYLfBi/xONhkTRmbgKsFVPrkdPnyZD0knAqs7qEtks5FisaYCstrdmkQ=
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 (2603:10b6:61f:fc00::278) by LV3PR07MB9971.namprd07.prod.outlook.com
 (2603:10b6:408:1b0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Mon, 14 Apr
 2025 03:52:33 +0000
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::2e5:1b6b:f0e1:26ec]) by CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::2e5:1b6b:f0e1:26ec%7]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 03:52:33 +0000
From: Manikandan Karunakaran Pillai <mpillai@cadence.com>
To: Rob Herring <robh@kernel.org>,
        "hans.zhang@cixtech.com"
	<hans.zhang@cixtech.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
        "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "conor+dt@kernel.org"
	<conor+dt@kernel.org>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 5/6] PCI: cadence: Add callback functions for RP and EP
 controller
Thread-Topic: [PATCH v3 5/6] PCI: cadence: Add callback functions for RP and
 EP controller
Thread-Index: AQHbqs2z8LAkUsD7cEi1IUkgIvKi1bOe6c0AgAOgkeA=
Date: Mon, 14 Apr 2025 03:52:32 +0000
Message-ID:
 <CH2PPF4D26F8E1C8ABE8B2902E5775F594FA2B32@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
References: <20250411103656.2740517-1-hans.zhang@cixtech.com>
 <20250411103656.2740517-6-hans.zhang@cixtech.com>
 <20250411202420.GA3793660-robh@kernel.org>
In-Reply-To: <20250411202420.GA3793660-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PPF4D26F8E1C:EE_|LV3PR07MB9971:EE_
x-ms-office365-filtering-correlation-id: 2377063e-3154-4461-99ec-08dd7b07c95e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?BckyLJxlFDpDInN44djVICatNpIcQujckp2kaIDwPdBk2i+16Wcsp/o1U/aP?=
 =?us-ascii?Q?Ny6Xt1KGnc4ZGejZaitSUzcJBwTsxoqxCqLpUc1sX73+sBEUH0pnyyXvxffn?=
 =?us-ascii?Q?tBbUTLhu6qwQIUAMAtWsLn0/YHXg1F9mLDIQtEjQIiwD4tRK8WhNdYEDrcs9?=
 =?us-ascii?Q?DtQzvgq9O8FC7nnFgoczFSR5IZrpx0Akj5fHvJsiqdMPaHaOrFvQxSVueNmH?=
 =?us-ascii?Q?VMBKr2pUxofhIyolqWyC4/L36m+YvU2ngtd/Zp5u3reIzYDIg9wGEJghTBlX?=
 =?us-ascii?Q?cy/w9K1hXaSY7lo+G9bQMdDJ8EIkU1K30Qianat5JF6awMi42KLnTZOLilla?=
 =?us-ascii?Q?7UESfNBx8nSwCb9kpjjmRX7OuGkvIJFQGzXB+841NseVSKAaD3IMTYNEaqbF?=
 =?us-ascii?Q?zsUtCrDzSk/l83OF6c3jl5e78E6laW6nRM1i59+hBr8Uc9fqVs9KlWpiZQ2l?=
 =?us-ascii?Q?SGXnA7/VRYdxSvdQ/sh94rZDUnl5nP+cG2+MozvMh9LiNkbFb09FBnMI9g1c?=
 =?us-ascii?Q?cELbcMaqE9RZEIe6yIESIpTqltfFMOHNzeYTzk0stp7PEridU4dO90xlfUkt?=
 =?us-ascii?Q?LyVROw8YpSQaMWyUDxLl6sc/gHy9SESt46j3GjmLr29n/gOOlgWTN8PiKspn?=
 =?us-ascii?Q?ObLG4cdGT+FTXM8i5ujsXyhZ+1w0IqY4mGOH82kxXnHex1Irg+98w8sHMqWf?=
 =?us-ascii?Q?lETtREQQwxdR6drYYo1nhaSv/9MtPzfeoOe4wOnyJYCYVdQvkJJcDSkvJci2?=
 =?us-ascii?Q?eSByNxp8OgJP39q73idD7xBzriB0toLwjOi5Gd4CspkaLDtwoBeny8p3l5zJ?=
 =?us-ascii?Q?DQislLeoaol/z9keU05x8MDxWTlfzErMZzCZGKnZmEVLhJAEiRcowEV8R0HZ?=
 =?us-ascii?Q?r/tLE9B3OucpbxBQEQi6Y4cYlxmohXAvvwZykCJopngFjI4gmwrINyAuennF?=
 =?us-ascii?Q?fsRb2f2XokEzMf5xz/kgcqniJjz8GPQ8ya07b3maiB8eEnloIAdkTqlEH4Ox?=
 =?us-ascii?Q?c8EznkQO1X9Y3oqz1j5SWcMl3k4hKQk3CYD8CVhF+dzUdvsbONwsK2VyDR24?=
 =?us-ascii?Q?af0lm5rMlTpf84M2XTGSOq1bXdo3r83vJXs8HLFlMnY6eBFDRBz1tdymzjm1?=
 =?us-ascii?Q?XeyFQlvVMHLtmUXlv/QIuzfZqalhAovGpmh21HCt2dMVcsILQwTHdh3andLf?=
 =?us-ascii?Q?wbL5ogxlAib902+IWQt36idFKJ0ENvJ8pPfn1t07uxv5fZ/5QqcgB+baucxR?=
 =?us-ascii?Q?rdMkCDbF4dGbUOz+eOW+hFpw2Ea298ilDymq2naOBi9lpvt/AUHdARAMr4Iq?=
 =?us-ascii?Q?kkWqQoidkCyuu9FhB/uAH+UVriNkzcyIfbkHJxeBuxUUunyCM9q63gvp2qHZ?=
 =?us-ascii?Q?5+MKekx7rd25smIncy8xCCpVVkDFARLyB2PC3/mGQ585l5FOGLhMQPwBv5zM?=
 =?us-ascii?Q?MhJGKE9gQyzSNAMptIFJ1cFVLoNxkbzUkfaJrsOR6rdDKOzeOub04A=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PPF4D26F8E1C.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?sPFkG0G2On4cqMXenqpPjn6NFA1tQfoEcR2PZS5UWmO/540Rn/Sa6x7L6NXp?=
 =?us-ascii?Q?cqpJJvSKBVwH4JC7D+S7uNahMp7WGWnV6WrvM6SjxsW+v4p5k5lg5vt9IlY2?=
 =?us-ascii?Q?8cUxBgs/dAo8SDggXvEs7PFk/ztHz1JMfomqRs6Hv95Eaa0pU8HGDmj3UkEb?=
 =?us-ascii?Q?OmOirhMQZvsuC9AsyVqc0h5lbpoLsJx4/aOMNnd2Y4sJ6+/Sh5kizdzBT9F3?=
 =?us-ascii?Q?uCHaV1BC55h9xbzubsHT79WRGKDC5nVxEzMAdh5bqtpmHjiKG1ynwb642clt?=
 =?us-ascii?Q?t/kFxsPwbmzW3z6S22TiZ9b9VwsdR0Cb/AtMyYmSwz9dq/bxiWUSt4pP/Xxy?=
 =?us-ascii?Q?udgDBxKJ8qTGKwexycYPjcHUq0IGz/vxNKyblWl//S3XFbK84kTN1RZgi24Y?=
 =?us-ascii?Q?ncFdFJKWyRbR1ENiUTr8TgN2DX0WokxsmQ+YIDkWSmAbzKn/zRt7cvle1hGx?=
 =?us-ascii?Q?HfEqZ7Yo5wpZpCp939KKosg3wY6EqSkSD1FqMioH+F3rRcIY/GKijmQh6vCq?=
 =?us-ascii?Q?xfIPofLO7bDUMuRdDwOxERHRpBtNJZveLxV/8ITmnjtPDFCC/pSY7+q1LqTx?=
 =?us-ascii?Q?kQLAMm8+9PCasMg7ujpxJstBPm0BCmSSgOaK1icNU5NyffzF2ROdRlmgMJPU?=
 =?us-ascii?Q?pAxv/tsNEq3K+IROoro7cMCt1LPKaZMiFVy1V74Zw1PT7ij0SHKFgumzmH3+?=
 =?us-ascii?Q?hz7V66HWMqslA0/HH/Wh7kMrYQGVal+ja0AoM1eD2nWRli4Fhkza/k6IDdKP?=
 =?us-ascii?Q?Z5OpTlNJvezPuqA+mrClvuyS0mII1SbN4tNJaPvlNi/iKCMD/L4SshBVqXjo?=
 =?us-ascii?Q?2YvPlfTmpA+OrInh0MOtTQusMN7AJMQ3VYYLvOOLOaxRJH9ZbRVP5cgJB3Gz?=
 =?us-ascii?Q?X7OSJj2tiCKnaFPMfzDiNzCOSm8QzNrDksANlRKfNvm4c1TsP9EABecbHyPE?=
 =?us-ascii?Q?OmMTeNyY+AJzBNW7SCHJRh49rD7lwpLMwpDLqdKh+Wc3IsSbpUqajvdnuxQq?=
 =?us-ascii?Q?AS8UPgvq4uYTMkgNYavZAQK5gdXxu5117hJMG585iG7C1z8c41JJdHYLhG2g?=
 =?us-ascii?Q?Go6eKkUozgnjsalofszgTgb01pkvnLfqvrJzhlupKWw1YKOYlaHLwqRQDSgR?=
 =?us-ascii?Q?0NAiDDTXbkyqcZ1h6QRrQKyHbmdnpCcKh+nAMYu2mqsanyn0kIZRstRybmpV?=
 =?us-ascii?Q?q6zu17tsJ04zVlud0N0suLnhvuNmCJsTB+fDDc66yfKxIIJ5oQJIzkkfyC3q?=
 =?us-ascii?Q?uExX2GM4lFqjFNvnj7oOgmfTN+TX2U0dHu2djSF6N1NR/AF55eaHTEwvQVI2?=
 =?us-ascii?Q?q4bMHNduSWYFY89SfjcOB2Qvo7NsdfDiexX/5DpBFzW1eUROtsGBw++nLERW?=
 =?us-ascii?Q?OP7m4Y+4DXGIOa5Nrd+8KClink8BqftxtNaoCD1mhcpNrfiwakDtCFacukU7?=
 =?us-ascii?Q?NLS/jwXHF9Y5jVPOTuCrqMrWBQM78Q6E30OqIq//wkTMNrkHD5YEi/v48Qne?=
 =?us-ascii?Q?qeoSf60+oZuN/RqCEOviz2aly04uFmnYoqUtiepEYzyEZMIf4xQPJ7a9oUmS?=
 =?us-ascii?Q?vWVw21QqhWW37jAb6G6JUrp7GT0ngfqf5UhsaMQE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PPF4D26F8E1C.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2377063e-3154-4461-99ec-08dd7b07c95e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2025 03:52:32.9822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: laYc+GiiN5BbHhsHSg3tfg70U7EQA53Gaf2jfj+FEV/OFk8yBjN8Ya+XK0ITdxVXv0WZf39keWz6wf8hWL8cfzAIVJtp/Xy+6LbNBYytOjw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR07MB9971
X-Proofpoint-GUID: NklBDI9r9KIStARFoO2rxP--G8Csd40v
X-Proofpoint-ORIG-GUID: NklBDI9r9KIStARFoO2rxP--G8Csd40v
X-Authority-Analysis: v=2.4 cv=X81SKHTe c=1 sm=1 tr=0 ts=67fc8683 cx=c_pps a=dnQYvCYIB+Ymp8NUOuD+qQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=XR8D0OoHHMoA:10 a=Zpq2whiEiuAA:10 a=dZDPGkURXkJ3OfA9wvEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 malwarescore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504140027

>> +void __iomem *cdns_pci_hpa_map_bus(struct pci_bus *bus, unsigned int
>devfn,
>> +				   int where)
>> +{
>> +	struct pci_host_bridge *bridge =3D pci_find_host_bridge(bus);
>> +	struct cdns_pcie_rc *rc =3D pci_host_bridge_priv(bridge);
>> +	struct cdns_pcie *pcie =3D &rc->pcie;
>> +	unsigned int busn =3D bus->number;
>> +	u32 addr0, desc0, desc1, ctrl0;
>> +	u32 regval;
>> +
>> +	if (pci_is_root_bus(bus)) {
>> +		/*
>> +		 * Only the root port (devfn =3D=3D 0) is connected to this bus.
>> +		 * All other PCI devices are behind some bridge hence on
>another
>> +		 * bus.
>> +		 */
>> +		if (devfn)
>> +			return NULL;
>> +
>> +		return pcie->reg_base + (where & 0xfff);
>> +	}
>> +
>> +	/*
>> +	 * Clear AXI link-down status
>> +	 */
>
>That is an odd thing to do in map_bus. Also, it is completely racy
>because...
>
>> +	regval =3D cdns_pcie_hpa_readl(pcie, REG_BANK_AXI_SLAVE,
>CDNS_PCIE_HPA_AT_LINKDOWN);
>> +	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
>CDNS_PCIE_HPA_AT_LINKDOWN,
>> +			     (regval & GENMASK(0, 0)));
>> +
>
>What if the link goes down again here.
>
>> +	desc1 =3D 0;
>> +	ctrl0 =3D 0;
>> +
>> +	/*
>> +	 * Update Output registers for AXI region 0.
>> +	 */
>> +	addr0 =3D CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_NBITS(12) |
>> +		CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_DEVFN(devfn) |
>> +		CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0_BUS(busn);
>> +	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
>> +			     CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0(0),
>addr0);
>> +
>> +	desc1 =3D cdns_pcie_hpa_readl(pcie, REG_BANK_AXI_SLAVE,
>> +
>CDNS_PCIE_HPA_AT_OB_REGION_DESC1(0));
>> +	desc1 &=3D ~CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN_MASK;
>> +	desc1 |=3D CDNS_PCIE_HPA_AT_OB_REGION_DESC1_DEVFN(0);
>> +	ctrl0 =3D CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_BUS |
>> +		CDNS_PCIE_HPA_AT_OB_REGION_CTRL0_SUPPLY_DEV_FN;
>> +
>> +	if (busn =3D=3D bridge->busnr + 1)
>> +		desc0 |=3D
>CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_CONF_TYPE0;
>> +	else
>> +		desc0 |=3D
>CDNS_PCIE_HPA_AT_OB_REGION_DESC0_TYPE_CONF_TYPE1;
>> +
>> +	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
>> +			     CDNS_PCIE_HPA_AT_OB_REGION_DESC0(0), desc0);
>> +	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
>> +			     CDNS_PCIE_HPA_AT_OB_REGION_DESC1(0), desc1);
>> +	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
>> +			     CDNS_PCIE_HPA_AT_OB_REGION_CTRL0(0), ctrl0);
>
>This is also racy with the read and write functions. Don't worry, lots
>of other broken h/w like this...
>
>Surely this new h/w supports ECAM style config accesses? If so, use
>and support that mode instead.
>

As an IP related driver, the  ECAM address in the SoC is not available. For=
 SoC, the=20
Vendor can override this function in their code with the ECAM address.

>> +
>> +	return rc->cfg_base + (where & 0xfff);
>> +}
>> +
>>  static struct pci_ops cdns_pcie_host_ops =3D {
>>  	.map_bus	=3D cdns_pci_map_bus,
>>  	.read		=3D pci_generic_config_read,
>>  	.write		=3D pci_generic_config_write,
>>  };
>>
>> +static struct pci_ops cdns_pcie_hpa_host_ops =3D {
>> +	.map_bus	=3D cdns_pci_hpa_map_bus,
>> +	.read           =3D pci_generic_config_read,
>> +	.write		=3D pci_generic_config_write,
>> +};
>> +
>>  static int cdns_pcie_host_training_complete(struct cdns_pcie *pcie)
>>  {
>>  	u32 pcie_cap_off =3D CDNS_PCIE_RP_CAP_OFFSET;
>> @@ -154,8 +220,14 @@ static void
>cdns_pcie_host_enable_ptm_response(struct cdns_pcie *pcie)
>>  {
>>  	u32 val;
>>
>> -	val =3D cdns_pcie_readl(pcie, CDNS_PCIE_LM_PTM_CTRL);
>> -	cdns_pcie_writel(pcie, CDNS_PCIE_LM_PTM_CTRL, val |
>CDNS_PCIE_LM_TPM_CTRL_PTMRSEN);
>> +	if (!pcie->is_hpa) {
>> +		val =3D cdns_pcie_readl(pcie, CDNS_PCIE_LM_PTM_CTRL);
>> +		cdns_pcie_writel(pcie, CDNS_PCIE_LM_PTM_CTRL, val |
>CDNS_PCIE_LM_TPM_CTRL_PTMRSEN);
>> +	} else {
>> +		val =3D cdns_pcie_hpa_readl(pcie, REG_BANK_IP_REG,
>CDNS_PCIE_HPA_LM_PTM_CTRL);
>> +		cdns_pcie_hpa_writel(pcie, REG_BANK_IP_REG,
>CDNS_PCIE_HPA_LM_PTM_CTRL,
>> +				     val |
>CDNS_PCIE_HPA_LM_TPM_CTRL_PTMRSEN);
>> +	}
>>  }
>>
>>  static int cdns_pcie_host_start_link(struct cdns_pcie_rc *rc)
>> @@ -340,8 +412,8 @@ static int cdns_pcie_host_bar_config(struct
>cdns_pcie_rc *rc,
>>  		 */
>>  		bar =3D cdns_pcie_host_find_min_bar(rc, size);
>>  		if (bar !=3D RP_BAR_UNDEFINED) {
>> -			ret =3D cdns_pcie_host_bar_ib_config(rc, bar, cpu_addr,
>> -							   size, flags);
>> +			ret =3D pcie->ops->host_bar_ib_config(rc, bar, cpu_addr,
>> +							    size, flags);
>>  			if (ret)
>>  				dev_err(dev, "IB BAR: %d config failed\n", bar);
>>  			return ret;
>> @@ -366,8 +438,7 @@ static int cdns_pcie_host_bar_config(struct
>cdns_pcie_rc *rc,
>>  		}
>>
>>  		winsize =3D bar_max_size[bar];
>> -		ret =3D cdns_pcie_host_bar_ib_config(rc, bar, cpu_addr, winsize,
>> -						   flags);
>> +		ret =3D pcie->ops->host_bar_ib_config(rc, bar, cpu_addr, winsize,
>flags);
>>  		if (ret) {
>>  			dev_err(dev, "IB BAR: %d config failed\n", bar);
>>  			return ret;
>> @@ -408,8 +479,8 @@ static int cdns_pcie_host_map_dma_ranges(struct
>cdns_pcie_rc *rc)
>>  	if (list_empty(&bridge->dma_ranges)) {
>>  		of_property_read_u32(np, "cdns,no-bar-match-nbits",
>>  				     &no_bar_nbits);
>> -		err =3D cdns_pcie_host_bar_ib_config(rc, RP_NO_BAR, 0x0,
>> -						   (u64)1 << no_bar_nbits, 0);
>> +		err =3D pcie->ops->host_bar_ib_config(rc, RP_NO_BAR, 0x0,
>> +						    (u64)1 << no_bar_nbits, 0);
>>  		if (err)
>>  			dev_err(dev, "IB BAR: %d config failed\n",
>RP_NO_BAR);
>>  		return err;
>> @@ -467,17 +538,159 @@ int
>cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc)
>>  		u64 pci_addr =3D res->start - entry->offset;
>>
>>  		if (resource_type(res) =3D=3D IORESOURCE_IO)
>> -			cdns_pcie_set_outbound_region(pcie, busnr, 0, r,
>> -						      true,
>> -						      pci_pio_to_address(res-
>>start),
>> -						      pci_addr,
>> -						      resource_size(res));
>> +			pcie->ops->set_outbound_region(pcie, busnr, 0, r,
>> +						       true,
>> +						       pci_pio_to_address(res-
>>start),
>> +						       pci_addr,
>> +						       resource_size(res));
>> +		else
>> +			pcie->ops->set_outbound_region(pcie, busnr, 0, r,
>> +						       false,
>> +						       res->start,
>> +						       pci_addr,
>> +						       resource_size(res));
>> +
>> +		r++;
>> +	}
>> +
>> +	return cdns_pcie_host_map_dma_ranges(rc);
>> +}
>> +
>> +int cdns_pcie_hpa_host_init_root_port(struct cdns_pcie_rc *rc)
>> +{
>> +	struct cdns_pcie *pcie =3D &rc->pcie;
>> +	u32 value, ctrl;
>> +
>> +	/*
>> +	 * Set the root complex BAR configuration register:
>> +	 * - disable both BAR0 and BAR1.
>> +	 * - enable Prefetchable Memory Base and Limit registers in type 1
>> +	 *   config space (64 bits).
>> +	 * - enable IO Base and Limit registers in type 1 config
>> +	 *   space (32 bits).
>> +	 */
>> +
>> +	ctrl =3D CDNS_PCIE_HPA_LM_BAR_CFG_CTRL_DISABLED;
>> +	value =3D CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR0_CTRL(ctrl) |
>> +		CDNS_PCIE_HPA_LM_RC_BAR_CFG_BAR1_CTRL(ctrl) |
>> +		CDNS_PCIE_HPA_LM_RC_BAR_CFG_PREFETCH_MEM_ENABLE
>|
>> +		CDNS_PCIE_HPA_LM_RC_BAR_CFG_PREFETCH_MEM_64BITS |
>> +		CDNS_PCIE_HPA_LM_RC_BAR_CFG_IO_ENABLE |
>> +		CDNS_PCIE_HPA_LM_RC_BAR_CFG_IO_32BITS;
>> +	cdns_pcie_hpa_writel(pcie, REG_BANK_IP_CFG_CTRL_REG,
>> +			     CDNS_PCIE_HPA_LM_RC_BAR_CFG, value);
>> +
>> +	if (rc->vendor_id !=3D 0xffff)
>> +		cdns_pcie_rp_writew(pcie, PCI_VENDOR_ID, rc->vendor_id);
>> +
>> +	if (rc->device_id !=3D 0xffff)
>> +		cdns_pcie_rp_writew(pcie, PCI_DEVICE_ID, rc->device_id);
>> +
>> +	cdns_pcie_rp_writeb(pcie, PCI_CLASS_REVISION, 0);
>> +	cdns_pcie_rp_writeb(pcie, PCI_CLASS_PROG, 0);
>> +	cdns_pcie_rp_writew(pcie, PCI_CLASS_DEVICE,
>PCI_CLASS_BRIDGE_PCI);
>> +
>> +	return 0;
>> +}
>> +
>> +int cdns_pcie_hpa_host_bar_ib_config(struct cdns_pcie_rc *rc,
>> +				     enum cdns_pcie_rp_bar bar,
>> +				     u64 cpu_addr, u64 size,
>> +				     unsigned long flags)
>> +{
>> +	struct cdns_pcie *pcie =3D &rc->pcie;
>> +	u32 addr0, addr1, aperture, value;
>> +
>> +	if (!rc->avail_ib_bar[bar])
>> +		return -EBUSY;
>> +
>> +	rc->avail_ib_bar[bar] =3D false;
>> +
>> +	aperture =3D ilog2(size);
>> +	addr0 =3D CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0_NBITS(aperture) |
>> +		(lower_32_bits(cpu_addr) & GENMASK(31, 8));
>> +	addr1 =3D upper_32_bits(cpu_addr);
>> +	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_MASTER,
>> +			     CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR0(bar),
>addr0);
>> +	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_MASTER,
>> +			     CDNS_PCIE_HPA_AT_IB_RP_BAR_ADDR1(bar),
>addr1);
>> +
>> +	if (bar =3D=3D RP_NO_BAR)
>> +		return 0;
>> +
>> +	value =3D cdns_pcie_hpa_readl(pcie, REG_BANK_IP_CFG_CTRL_REG,
>CDNS_PCIE_HPA_LM_RC_BAR_CFG);
>> +	value &=3D ~(HPA_LM_RC_BAR_CFG_CTRL_MEM_64BITS(bar) |
>> +		   HPA_LM_RC_BAR_CFG_CTRL_PREF_MEM_64BITS(bar) |
>> +		   HPA_LM_RC_BAR_CFG_CTRL_MEM_32BITS(bar) |
>> +		   HPA_LM_RC_BAR_CFG_CTRL_PREF_MEM_32BITS(bar) |
>> +		   HPA_LM_RC_BAR_CFG_APERTURE(bar,
>bar_aperture_mask[bar] + 2));
>> +	if (size + cpu_addr >=3D SZ_4G) {
>> +		if (!(flags & IORESOURCE_PREFETCH))
>> +			value |=3D
>HPA_LM_RC_BAR_CFG_CTRL_MEM_64BITS(bar);
>> +		value |=3D
>HPA_LM_RC_BAR_CFG_CTRL_PREF_MEM_64BITS(bar);
>> +	} else {
>> +		if (!(flags & IORESOURCE_PREFETCH))
>> +			value |=3D
>HPA_LM_RC_BAR_CFG_CTRL_MEM_32BITS(bar);
>> +		value |=3D
>HPA_LM_RC_BAR_CFG_CTRL_PREF_MEM_32BITS(bar);
>> +	}
>> +
>> +	value |=3D HPA_LM_RC_BAR_CFG_APERTURE(bar, aperture);
>> +	cdns_pcie_hpa_writel(pcie, REG_BANK_IP_CFG_CTRL_REG,
>CDNS_PCIE_HPA_LM_RC_BAR_CFG, value);
>> +
>> +	return 0;
>> +}
>> +
>> +int cdns_pcie_hpa_host_init_address_translation(struct cdns_pcie_rc *rc=
)
>> +{
>> +	struct cdns_pcie *pcie =3D &rc->pcie;
>> +	struct pci_host_bridge *bridge =3D pci_host_bridge_from_priv(rc);
>> +	struct resource *cfg_res =3D rc->cfg_res;
>> +	struct resource_entry *entry;
>> +	u64 cpu_addr =3D cfg_res->start;
>> +	u32 addr0, addr1, desc1;
>> +	int r, busnr =3D 0;
>> +
>> +	entry =3D resource_list_first_type(&bridge->windows,
>IORESOURCE_BUS);
>> +	if (entry)
>> +		busnr =3D entry->res->start;
>> +
>> +	/*
>> +	 * Reserve region 0 for PCI configure space accesses:
>> +	 * OB_REGION_PCI_ADDR0 and OB_REGION_DESC0 are updated
>dynamically by
>> +	 * cdns_pci_map_bus(), other region registers are set here once for al=
l.
>> +	 */
>> +	addr1 =3D 0;
>> +	desc1 =3D CDNS_PCIE_HPA_AT_OB_REGION_DESC1_BUS(busnr);
>> +	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
>> +			     CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR1(0),
>addr1);
>> +	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
>> +			     CDNS_PCIE_HPA_AT_OB_REGION_DESC1(0), desc1);
>> +
>> +	addr0 =3D CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0_NBITS(12) |
>> +		(lower_32_bits(cpu_addr) & GENMASK(31, 8));
>> +	addr1 =3D upper_32_bits(cpu_addr);
>> +	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
>> +			     CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0(0),
>addr0);
>> +	cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
>> +			     CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR1(0),
>addr1);
>> +
>> +	r =3D 1;
>> +	resource_list_for_each_entry(entry, &bridge->windows) {
>> +		struct resource *res =3D entry->res;
>> +		u64 pci_addr =3D res->start - entry->offset;
>> +
>> +		if (resource_type(res) =3D=3D IORESOURCE_IO)
>> +			pcie->ops->set_outbound_region(pcie, busnr, 0, r,
>> +						       true,
>> +						       pci_pio_to_address(res-
>>start),
>> +						       pci_addr,
>> +						       resource_size(res));
>>  		else
>> -			cdns_pcie_set_outbound_region(pcie, busnr, 0, r,
>> -						      false,
>> -						      res->start,
>> -						      pci_addr,
>> -						      resource_size(res));
>> +			pcie->ops->set_outbound_region(pcie, busnr, 0, r,
>> +						       false,
>> +						       res->start,
>> +						       pci_addr,
>> +						       resource_size(res));
>>
>>  		r++;
>>  	}
>> @@ -489,11 +702,11 @@ int cdns_pcie_host_init(struct cdns_pcie_rc *rc)
>>  {
>>  	int err;
>>
>> -	err =3D cdns_pcie_host_init_root_port(rc);
>> +	err =3D rc->pcie.ops->host_init_root_port(rc);
>>  	if (err)
>>  		return err;
>>
>> -	return cdns_pcie_host_init_address_translation(rc);
>> +	return rc->pcie.ops->host_init_address_translation(rc);
>>  }
>>
>>  int cdns_pcie_host_link_setup(struct cdns_pcie_rc *rc)
>> @@ -503,7 +716,7 @@ int cdns_pcie_host_link_setup(struct cdns_pcie_rc
>*rc)
>>  	int ret;
>>
>>  	if (rc->quirk_detect_quiet_flag)
>> -		cdns_pcie_detect_quiet_min_delay_set(&rc->pcie);
>> +		pcie->ops->detect_quiet_min_delay_set(&rc->pcie);
>>
>>  	cdns_pcie_host_enable_ptm_response(pcie);
>>
>> @@ -566,8 +779,12 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
>>  	if (ret)
>>  		return ret;
>>
>> -	if (!bridge->ops)
>> -		bridge->ops =3D &cdns_pcie_host_ops;
>> +	if (!bridge->ops) {
>> +		if (pcie->is_hpa)
>> +			bridge->ops =3D &cdns_pcie_hpa_host_ops;
>> +		else
>> +			bridge->ops =3D &cdns_pcie_host_ops;
>> +	}
>>
>>  	ret =3D pci_host_probe(bridge);
>>  	if (ret < 0)
>> diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c
>b/drivers/pci/controller/cadence/pcie-cadence-plat.c
>> index b24176d4df1f..8d5fbaef0a3c 100644
>> --- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
>> +++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
>> @@ -43,7 +43,30 @@ static u64 cdns_plat_cpu_addr_fixup(struct cdns_pcie
>*pcie, u64 cpu_addr)
>>  }
>>
>>  static const struct cdns_pcie_ops cdns_plat_ops =3D {
>> +	.link_up =3D cdns_pcie_linkup,
>>  	.cpu_addr_fixup =3D cdns_plat_cpu_addr_fixup,
>> +	.host_init_root_port =3D cdns_pcie_host_init_root_port,
>> +	.host_bar_ib_config =3D cdns_pcie_host_bar_ib_config,
>> +	.host_init_address_translation =3D
>cdns_pcie_host_init_address_translation,
>> +	.detect_quiet_min_delay_set =3D
>cdns_pcie_detect_quiet_min_delay_set,
>> +	.set_outbound_region =3D cdns_pcie_set_outbound_region,
>> +	.set_outbound_region_for_normal_msg =3D
>> +
>cdns_pcie_set_outbound_region_for_normal_msg,
>> +	.reset_outbound_region =3D cdns_pcie_reset_outbound_region,
>> +};
>> +
>> +static const struct cdns_pcie_ops cdns_hpa_plat_ops =3D {
>> +	.start_link =3D cdns_pcie_hpa_startlink,
>> +	.stop_link =3D cdns_pcie_hpa_stop_link,
>> +	.link_up =3D cdns_pcie_hpa_linkup,
>> +	.host_init_root_port =3D cdns_pcie_hpa_host_init_root_port,
>> +	.host_bar_ib_config =3D cdns_pcie_hpa_host_bar_ib_config,
>> +	.host_init_address_translation =3D
>cdns_pcie_hpa_host_init_address_translation,
>> +	.detect_quiet_min_delay_set =3D
>cdns_pcie_hpa_detect_quiet_min_delay_set,
>> +	.set_outbound_region =3D cdns_pcie_hpa_set_outbound_region,
>> +	.set_outbound_region_for_normal_msg =3D
>> +
>cdns_pcie_hpa_set_outbound_region_for_normal_msg,
>> +	.reset_outbound_region =3D cdns_pcie_hpa_reset_outbound_region,
>
>What exactly is shared between these 2 implementations. Link handling,
>config space accesses, address translation, and host init are all
>different. What's left to share? MSIs (if not passed thru) and
>interrupts? I think it's questionable that this be the same driver.
>
The address of both these have changed as the controller architecture has
changed. In the event these driver have to be same driver, there will lot o=
f=20
sprinkled "if(is_hpa)" and that was already rejected in earlier version of =
code.
Hence it was done similar to other drivers by architecture specific "ops".
The "if(is_hpa)" is now very limited where a specific ops functions does no=
t make
any sense.

>A bunch of driver specific 'ops' is not the right direction despite
>other drivers (DWC) having that. If there are common parts, then make
>them library functions multiple drivers can call.
>
>Rob

