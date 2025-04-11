Return-Path: <linux-pci+bounces-25649-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DF7A85270
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 06:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E537B3B8B63
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 04:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D693234;
	Fri, 11 Apr 2025 04:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="j+R/4iVi";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="4O1S90KQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE9E29A1;
	Fri, 11 Apr 2025 04:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744345014; cv=fail; b=I0pGCRlsjaPy19tF8kK0xwecCgqCk9r8h7ys9ETnRs/G1UbvVQj2rxDDU/KWTCBpp+gTLMmGD28gGK99kRO18df6p7YOzQE4U9eqqKfBk57mQsTdSdRqK0Kv/EPdPUFnPxLeajrAGDFXWI47pZcn4VBTa0hyx0zX0u4BZfV8p7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744345014; c=relaxed/simple;
	bh=tu98y/Z6cuHXgHqpIx7WWP6+R65VBBbeEEK5ARw0ArI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hoA4ZU3RZmmB6kqVzg38p379Vj1SWRvYl4MDAf8iDzg0T/ekW4uw7tvSRWccQDqbJPeS4iAnuYhg5iKRGvjH2otBG/rrh91szz6pzLg+fyHpmMKj7N5NRV1RfNiBSVVY55yrn9BsgcPrllgei8ctC1k3nYd0WCUdPwn5GS9xSdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=j+R/4iVi; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=4O1S90KQ; arc=fail smtp.client-ip=208.84.65.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
	by mx0a-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53AKwgvq001972;
	Thu, 10 Apr 2025 21:16:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=1kkq54SzcmUhrtD7C3O1LKQYiUosE2i6q1XgwOSE9Q4=; b=j+R/4iViSUwR
	SqBoUYhv0i7zXZdjYDKRyKHdj3iBop1u7/Qkpw4Tl1gRD7kEwTDLc4xCKHUh3F8O
	C0oGnqFjGPrsMG4t9NuEeHWxVhkxP/Phb4O/f2ZSLoklyq/ROVbFNnjGH0M1ICNP
	m4ZyLt208q9XV1mkvP6MhGfNBeMYK6d3NwgGn3YEhEh6utMBV310FRbnNoCrDBxl
	wMU1M6xLh/HUaHNYQ4hQZBdjlgFRcPtTvvm3zL4TaM8ujtUpG42f4OW50kCFW9fg
	LJWgpkrKs3BuhOZK97qdRlsLHD3UWoNkT7dtQuHHIcgi2QUUPlzw/GZC6B+iZk6S
	NBE36XBl+g==
Received: from cy4pr02cu008.outbound.protection.outlook.com (mail-westcentralusazlp17011029.outbound.protection.outlook.com [40.93.6.29])
	by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 45vbd2wv8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 21:16:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qj2lfrJLB0O3mOAxnDDJbBzsEd9XzkPAZwAXHLHcsokR63cqSPgAITwXAd/TsCSrHvQHYHI0r35i0GTLiNafekINfhVeFYhMWC6Sl/RRuqGPdgqc/LxuQggWj7jR7FcqJXcGr0BE225wOh9XzKIPOqZPE3ikCTRfivzZGiBOWvfabkq8bWku69lzC8lDv+VMKemTMSsb3y7uCDrRl7s0t8jz5aLCOvJciEc95xFdqeWsOEUutW51PnzPYmmo4vNlFSgsHiGoXNT7cmLFEcswXeCnibV2nC2SBZN18+o3YZVnWiKCthVict3Kcl18hsCZ7Ucc56aSpa4HJrkXkuwHrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1kkq54SzcmUhrtD7C3O1LKQYiUosE2i6q1XgwOSE9Q4=;
 b=Wr8UxDa7i41iTNourjMlmlHP4m4ptNjLG37axybv0sArkPB1mMUCKrjJspj1XAyCGt/R8W6VSzlWav9l/idpNivH7d/fK+YTDCQyybWmpxptYqKSwcdGOqrkg40Uv1rbjV8WnrZEa/5vKn09IO4aRMOT1d0+r4oX1NAO7Pm8Hvc8dFHCIwVICRo2jR5yqEXA5RyqfWy26DjqozAGWKz7yYvw5rSU0jRCShZZfsEAH4ZnEahY+397gfaA5dQDwD6EodZ7BEpkBNytlOSIcZut2L2GJE7/f63TP2MbhdSIcOl4uaDz8x42TQ+JNuAOMQcWGK+/By9wUJladYFCESxPBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kkq54SzcmUhrtD7C3O1LKQYiUosE2i6q1XgwOSE9Q4=;
 b=4O1S90KQkxFv4dWn4NnOZVURpOF0xHjLEtFnkMIpMwJMOocCIWamr2Qv5F8YMAaaAc9uGCKCFcMH5/W6Ac3y1f6tXZl6n2kAIiLomK4ulVQi6+7KfXustcuUBt51hCtjfJMATm5bNW69rI6fmw6ORBorxw/2gozaMK1sRdEbypQ=
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 (2603:10b6:61f:fc00::278) by PH0PR07MB10693.namprd07.prod.outlook.com
 (2603:10b6:510:337::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.23; Fri, 11 Apr
 2025 04:16:42 +0000
Received: from CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::2e5:1b6b:f0e1:26ec]) by CH2PPF4D26F8E1C.namprd07.prod.outlook.com
 ([fe80::2e5:1b6b:f0e1:26ec%8]) with mapi id 15.20.8606.039; Fri, 11 Apr 2025
 04:16:42 +0000
From: Manikandan Karunakaran Pillai <mpillai@cadence.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
        "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 2/7] PCI: cadence: Add header support for PCIe next generation
 controllers
Thread-Topic: [PATCH 2/7] PCI: cadence: Add header support for PCIe next
 generation controllers
Thread-Index: AQHbnwkCpgh5QvQSuU67PmiD5J2SNrOG17lggBUJKYCAAhCwQA==
Date: Fri, 11 Apr 2025 04:16:42 +0000
Message-ID:
 <CH2PPF4D26F8E1C027259EF9266ECCBDB66A2B62@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
References:
 <CH2PPF4D26F8E1CE94EC3F4A0D6B9849818A2A12@CH2PPF4D26F8E1C.namprd07.prod.outlook.com>
 <20250409203923.GA295549@bhelgaas>
In-Reply-To: <20250409203923.GA295549@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PPF4D26F8E1C:EE_|PH0PR07MB10693:EE_
x-ms-office365-filtering-correlation-id: 6e6d6180-5a48-40da-92f4-08dd78afaa42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?O6ToqalMf4QitrntB5l8BfTl0DHC2mNmY3ZhvnpKhpJjysPaG+AZlt77Tz/8?=
 =?us-ascii?Q?W9ZjfPu/7j8INMJTk0hxS/qeQXMbU0A1L24hNoArb09sA+Az/m4PAgf1DJpp?=
 =?us-ascii?Q?eknG1gDh+Dnrzuyc67FCE+czCqbRXFgsAndsfnmjuPxpe5FDW/by8/s/PZ4y?=
 =?us-ascii?Q?gVgXkNW2AwVIyVtdqlwQ9okaitOlHnH/AMH2R+Ls8F49augCV7odNh7T5ZbU?=
 =?us-ascii?Q?mdNR2scVwPNlk3z8aHEedrRk2Wx5H0ptQEuNS47pEhrmucPoKHuieJwjNjAk?=
 =?us-ascii?Q?gHjzbiCeDm2dfkpVX9r48r2okNV84lRNzWoQ71vnHQlcWfW3ZM/MW1y4DTor?=
 =?us-ascii?Q?dWeKXl9D7yzRHQcXYrBS3rRSlha7fAf5Vg7XQWT/ZjO7o6GKRgRUlYNi9k9f?=
 =?us-ascii?Q?eVr7jHn8DHxKnCsCknkFQQx1dzBja/+PLYJQisQd15OaWGqb4a4Tmi2sXqRE?=
 =?us-ascii?Q?SuIev6PwONt+Vfq4jDNCFMomWsQzBrlxIKg9MND/bUx8FnvbWpPQS7+6voRA?=
 =?us-ascii?Q?IlS9/Mm8NvVYe/olsKJwj12cKlcWEUR17R3QmKH9KYkUjkHklMLRooygOkMD?=
 =?us-ascii?Q?P/TaAl+/totikqhUBnYcEzdiJUmuJaevBpBpALuvrdzp4DHJR0lKsNPDTouc?=
 =?us-ascii?Q?18NydH56ie6eIoWBqZqVftXE8dVzkjkj4QAO/9X5IWffDMV/8PfNqbVqrOYQ?=
 =?us-ascii?Q?oqmNm1O0iQ2TiZBsoh0zgHAcGG66bxJtm0KW27GiS2MIoea9i4nrw7UKrJ/6?=
 =?us-ascii?Q?Oph3AYHjdb5Whv/9q/Eac0CAsEHyVqu9hUpeLsdjOaaC1Ly86sCETCTJNqCH?=
 =?us-ascii?Q?M//4slQkX++zCJsxAdNdefxEspsWAOUZHXA0f6GH6vcBMlK6cxLs389cTPu7?=
 =?us-ascii?Q?b2RJ1k+UzdgF0Ua/jILDoIcKt9PbpEQwOK87Acu4YQRBZmeQfqZ00GUH8Lr3?=
 =?us-ascii?Q?nabctBqB5TWhCPqDnbZPXhQ11vSD7S7xMcGsVGNFQ5BARqqEncX3/DXMp+Td?=
 =?us-ascii?Q?ciIgaS8uZ1YRdTQPqG4dDI7K0Hto3JA5rxCUT1ySjeEOhz9FWnW1JH7FDLbN?=
 =?us-ascii?Q?cRulQ+a6ZWqtFUjfipKKUY0gC/fVRMbUea5NweImnTybLu/uaVeqniOcqRce?=
 =?us-ascii?Q?ZitAUN/G+QupknDkMeAhh+fIZiv5x3Ut3IRzHHP5hxRufFzjNvYgt/BRTEA3?=
 =?us-ascii?Q?ESufq/hiyLzxrTXxOINKDXJSmAqUTFZTZACAzUJzMq0aSsMTdE0Jxp1l4MGE?=
 =?us-ascii?Q?sZLpqSJYscvqRSiIZ5BNQJmxxqnUmI48qgiWRjYoTGjbVZwME3H438k9A0bI?=
 =?us-ascii?Q?ZMwKN/1st5t2KNOJtMwBN7sNgtbmlK1QPscTWm2EJWssCRNZp6q4/zr4LKhu?=
 =?us-ascii?Q?d0q0bqpARv0SRrasfpp95s33bUwhxFkrnRvAPvMMbQNWxDZgopuYs70fINfH?=
 =?us-ascii?Q?pvAiHDXGds4iF6RbzfUhTQcqL6IXQdGSB6GlP4isomUEOuvTWIDKjTeUEXgd?=
 =?us-ascii?Q?Ge+DLZSGMytYh30=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PPF4D26F8E1C.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DLiwuA449OPqE+blvvHnvYRgoKJApfRMtGq9IclvJD5i6kNIzwjV1sN6EQyK?=
 =?us-ascii?Q?X6b7uQvhZL7iyZ3FQEFJjct3Ibq9NskoOqW5pyCiZIM7uLZH2q8ujDbpfuRD?=
 =?us-ascii?Q?4XJAqX7VulOz68ML6XgJ7DHMn7wC2CMYXQSPfT0pUDeWY48MC6dD34gwhYwW?=
 =?us-ascii?Q?pkwelurpHVSmXjxO7S2uTZoyxda0kf1qtGa2vLSQZeim8uoNc++Uo9GzG1HD?=
 =?us-ascii?Q?P0NPy032ZnZAUYFFEYFZCKw2BQifutao708kAjwwwMw/5sUqllhwPs73BalM?=
 =?us-ascii?Q?IrSRY1fj/zAh1Gy0vPpgGCOp18mesV09h4wS6N7g2fvI3hOQC1yxD1d/GfJ5?=
 =?us-ascii?Q?FyC904u6QAUKdEX9DE5tBCYGI2mxIJtuKqFzBW3sqZWlJU5FQMdkUq6wS4n0?=
 =?us-ascii?Q?uM3rRTh6Bkynu0wd93M+YZA2YxfT/udCy2cwTcUV5AjVxoycPFAPH2wrqURp?=
 =?us-ascii?Q?O2yPkeFSjFbN6Js/BRq7/SqkbNVz0qw2AacgQ5IfX6yaqhhFWJCtx+02I3ah?=
 =?us-ascii?Q?ekRfTo0PPEP2biuSgWMHGszEcrc1ao1t5QYn7Pnkkm+hqePMf5m6Cxo1BvbN?=
 =?us-ascii?Q?9OE+FpdxTEI3j4J+rqebourIDj27jkRaOeYqUsSlEXXrTZ+rxTMvvQhoTBeM?=
 =?us-ascii?Q?iEQN3hlBMsgeBRUgI1xISAOkaiVp2noTupB/WUT+P0jJpcBYQ79xuk7Fevlw?=
 =?us-ascii?Q?6yxSwFyQwgjh8XAdR6RxuITjTBbrTO3DH4L6t9tPxRB7L3dOu09qQUPjJSCw?=
 =?us-ascii?Q?ez2vnTo7mfV8hMNVAR1XQHexz8gnQXIAgNWVztPJoq3TqVcRClkCvQUaTENm?=
 =?us-ascii?Q?Uo/ZASxXvMNr5V7ZJY4DisVHJ3WCimpc6b4LVFFlKm4wbsohxtsgH9WyZSYa?=
 =?us-ascii?Q?rARcTJc+K5ZnELrrhGPaHJV9oO3nNybkwBOsmfqV5GCqzvlMESJU7gMuYPnd?=
 =?us-ascii?Q?ozvYH7IZugt5i5cykC/Lpj8QFB8I+aJKg1zqWWnJAv7RzMX5tVWofvsi5kF1?=
 =?us-ascii?Q?V59xZPgnQgmEaij9EZb1kxA6l0MmlDWdCv299jGQZqEOq4S2t2WkKX0ZH6gx?=
 =?us-ascii?Q?NOJnXDJB8ytc0ZqchJ3aA5mJMTZKVqmJr6G8UPIzZ+7IWzxx0w+V6yOgUmtA?=
 =?us-ascii?Q?bOhF6MhCeZ+OxQWazcfIeKkm0dwUJ+p5AqDYpPuB6FG7Jm3kuBF45JABdnh2?=
 =?us-ascii?Q?+lOmV1Ug1sPE2A8NVmozrH4j6dAyys0lLKgwOjuaTzY0Vbk7NHngtHxCUMC8?=
 =?us-ascii?Q?rZ+CKiFB9QYE5MTok/SyMqX9fjXV65QAL4oBq45flJvThO+lJ8yT/0zDcdKq?=
 =?us-ascii?Q?917lYkfATYZRCoy/UAOI+QibyNjNCbNwblTmuLeYgQbLvI/v2g3GVPs26yvv?=
 =?us-ascii?Q?QxNM8bzkLBY9Xrr3jTfFYPlmHSqW7ExbY25pgRmx2HQSvJSw+p5zEyThAuH8?=
 =?us-ascii?Q?J2c7fjmLxdLgQfPv2KL+oEyz9tdOiKn9y6q72iQZztzSFKhxo05x8K6VEdDf?=
 =?us-ascii?Q?Bm1eDpGagAqfKfHCo2HcpcnPbqn9oVGWZyhyIClydcVrsUhV1LpXXm3X+AEG?=
 =?us-ascii?Q?GHE/9j1Dd1mdBwak0TMiJVEtukEfmD8ADImVugf0GOj+GRkZgwdgdgB8qgXC?=
 =?us-ascii?Q?nw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e6d6180-5a48-40da-92f4-08dd78afaa42
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2025 04:16:42.7054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eXWwnoAcvxU0ml8KWrNXHtSNCjUw6WejbbpEm/av+BacaNIdu7Bjb++xhi/UHTtrddumV5dATc/kw7000Uwtb9oSrwhUM6g9Mcwk+MQIp+U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR07MB10693
X-Proofpoint-ORIG-GUID: lsJffB9upm-8oyUbSoZh-flBRMj07qMY
X-Authority-Analysis: v=2.4 cv=HIXDFptv c=1 sm=1 tr=0 ts=67f897ad cx=c_pps a=MGIL9jhmtb3Hqg0nl2vIzw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=XR8D0OoHHMoA:10 a=Zpq2whiEiuAA:10 a=sEGdoHQ-cMIKJbrvSkAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: lsJffB9upm-8oyUbSoZh-flBRMj07qMY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 clxscore=1015 malwarescore=0 mlxscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110029


>On Thu, Mar 27, 2025 at 11:26:21AM +0000, Manikandan Karunakaran Pillai
>wrote:
>> Add the required definitions for register addresses and register bits
>> for the next generation Cadence PCIe controllers - High performance
>> rchitecture(HPA) controllers. Define register access functions for
>> SoC platforms with different base address
>
>"Next generation" is not really meaningful since there will probably
>be a next-next generation, and "high performance architecture" is
>probably not much better because the next-next generation will
>presumably be "higher than high performance."
>
>I would just use the codename or marketing name and omit "next
>generation."  Maybe that's "HPA" and we can look forward to another
>superlative name for the next generation after this :)
>
"HPA" will be used from the next patch series

>s/High performance/High Performance/
>s/rchitecture/Architecture/
>
>Add period at end of sentence.
>
OK

>> +#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG(bar, fn) \
>> +	(((bar) < BAR_3) ? CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG0(fn) : \
>> +			CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG1(fn))
>> +#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG0(pfn) (0x4000 * (pfn))
>> +#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG1(pfn) ((0x4000 * (pfn)) +
>0x04)
>> +#define CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG(bar, fn) \
>> +	(((bar) < BAR_3) ? CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG0(fn) : \
>> +			CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG1(fn))
>> +#define CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG0(vfn) ((0x4000 * (vfn)) +
>0x08)
>> +#define CDNS_PCIE_HPA_LM_EP_VFUNC_BAR_CFG1(vfn) ((0x4000 * (vfn)) +
>0x0C)
>> +#define
>CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(f) \
>> +	(GENMASK(9, 4) << ((f) * 10))
>> +#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_APERTURE(b, a) \
>> +	(((a) << (4 + ((b) * 10))) &
>(CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_APERTURE_MASK(b)))
>> +#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(f) \
>> +	(GENMASK(3, 0) << ((f) * 10))
>> +#define CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_CTRL(b, c) \
>> +	(((c) << ((b) * 10)) &
>(CDNS_PCIE_HPA_LM_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b)))
>
>Wow, these names are ... loooong.  This would be more readable if they
>could be abbreviated a bit.  "PCIE" could be dropped with no loss.
>There are probably other words that could be dropped too.
>
The names are in sync with the hardware register specification and also wit=
h the existing
code for legacy Cadence PCIe controller. Hence would like to retain them fo=
r readability.

>>  struct cdns_pcie_ops {
>>  	int	(*start_link)(struct cdns_pcie *pcie);
>>  	void	(*stop_link)(struct cdns_pcie *pcie);
>>  	bool	(*link_up)(struct cdns_pcie *pcie);
>>  	u64     (*cpu_addr_fixup)(struct cdns_pcie *pcie, u64 cpu_addr);
>> +	int	(*pcie_host_init_root_port)(struct cdns_pcie_rc *rc);
>> +	int	(*pcie_host_bar_ib_config)(struct cdns_pcie_rc *rc,
>> +					   enum cdns_pcie_rp_bar bar,
>> +					   u64 cpu_addr, u64 size,
>> +					   unsigned long flags);
>> +	int	(*pcie_host_init_address_translation)(struct cdns_pcie_rc *rc);
>> +	void	(*pcie_detect_quiet_min_delay_set)(struct cdns_pcie *pcie);
>> +	void	(*pcie_set_outbound_region)(struct cdns_pcie *pcie, u8 busnr,
>u8 fn,
>> +					    u32 r, bool is_io, u64 cpu_addr,
>> +					    u64 pci_addr, size_t size);
>> +	void	(*pcie_set_outbound_region_for_normal_msg)(struct
>cdns_pcie *pcie,
>> +							   u8 busnr, u8 fn, u32 r,
>> +							   u64 cpu_addr);
>> +	void	(*pcie_reset_outbound_region)(struct cdns_pcie *pcie, u32 r);
>
>Also some pretty long names here that don't fit the style of the
>existing members (none of the others have the "pcie_" prefix).


"pcie" is removed from the function names to be in sync with other function=
 pointer naming

>
>> + * struct cdns_pcie_reg_offset - Register bank offset for a platform
>> + * @ip_reg_bank_off - ip register bank start offset
>> + * @iP_cfg_ctrl_reg_off - ip config contrl register start offset
>
>s/@iP_cfg_ctrl_reg_off/@ip_cfg_ctrl_reg_off/
>
>"scripts/kernel-doc -none <file>" should find errors like this for you.

kernel-doc --none is run on all the files for the next patch series
>
>s/contrl/control/
>
>> + * @axi_mstr_common_off - AXI master common register start
>> + * @axi_slave_off - AXI skave offset start
>
>s/skave/slave/
>
>> +struct cdns_pcie_reg_offset {
>> +	u32  ip_reg_bank_off;
>> +	u32  ip_cfg_ctrl_reg_off;
>> +	u32  axi_mstr_common_off;
>> +	u32  axi_slave_off;
>> +	u32  axi_master_off;
>> +	u32  axi_hls_off;
>> +	u32  axi_ras_off;
>> +	u32  axi_dti_off;
>>  };
>>
>>  /**
>> @@ -305,10 +551,12 @@ struct cdns_pcie {
>>  	struct resource		*mem_res;
>>  	struct device		*dev;
>>  	bool			is_rc;
>> +	bool			is_hpa;
>>  	int			phy_count;
>>  	struct phy		**phy;
>>  	struct device_link	**link;
>>  	const struct cdns_pcie_ops *ops;
>> +	struct cdns_pcie_reg_offset cdns_pcie_reg_offsets;
>
>Why does struct cdns_pcie need to contain an entire struct
>cdns_pcie_reg_offset instead of just a pointer to it?

The cdns_pci_reg_offset is declared only in this global store for further u=
sage by the driver. There is only
Struct defined for a PCIe controller and it made sense to define it inside =
this global context struct for controllers

>
>> +static inline u32 cdns_reg_bank_to_off(struct cdns_pcie *pcie, enum
>cdns_pcie_reg_bank bank)
>> +{
>> +	u32 offset;
>> +
>> +	switch (bank) {
>> +	case REG_BANK_IP_REG:
>> +		offset =3D pcie->cdns_pcie_reg_offsets.ip_reg_bank_off;
>
>It's a little hard to untangle this without being able to apply the
>series, but normally we would add the struct cdns_pcie_reg_offset
>definition, the inclusion in struct cdns_pcie, this use of it, and the
>setting of it in the same patch.
>
Ok

>>  #ifdef CONFIG_PCIE_CADENCE_EP
>> @@ -556,7 +909,10 @@ static inline int cdns_pcie_ep_setup(struct
>cdns_pcie_ep *ep)
>>  	return 0;
>>  }
>>  #endif
>> -
>
>Probably spurious change?  Looks like we would want the blank line
>here.
>
Ok

>> +bool cdns_pcie_linkup(struct cdns_pcie *pcie);
>> +bool cdns_pcie_hpa_linkup(struct cdns_pcie *pcie);
>> +int cdns_pcie_hpa_startlink(struct cdns_pcie *pcie);
>> +void cdns_pcie_hpa_stop_link(struct cdns_pcie *pcie);
>>  void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie);

