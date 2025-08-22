Return-Path: <linux-pci+bounces-34539-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C7EB3128B
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 11:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D76356000B
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 09:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7ECB2264D2;
	Fri, 22 Aug 2025 09:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RTf6HjzH"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013042.outbound.protection.outlook.com [52.101.72.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A8823278D;
	Fri, 22 Aug 2025 09:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755853634; cv=fail; b=mLDqj3Ugknka4dMv0czQ/o2LA2PhhsMLeqZPRzTGnWf/FOwTLyrYK3e/jSpY0NejRhIE05ptfJw0HC/8R3Pu7M74+Zuh7dJsXBBXpHY9eSo4d3AVZsPZz/4RfF+OOINwhcfk5JffqTTqv+MRmsS1zGMRyCYLy3dIa0V/Sqof0AU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755853634; c=relaxed/simple;
	bh=U6zBAwD66Ty+zoFkZc+lH/c9ClBKViS4ZHi+hrn0oi4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PALSoZRdDrf9EQ85tvgVb4nDil99gGfL4+ZykJnqIQ+ZCyqeJSendIjyskJwf+6BYiI/eECjt+9TldgMzVm0DqL3ZoINM0JYkeYIza1pqwMdk0gFwfbee/4kvD/5hKgtg7qzuWmesPCxDY72YlI9MM+tP49RG1RePYltDATD11M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RTf6HjzH; arc=fail smtp.client-ip=52.101.72.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tWQ5S/nTEeQf0zo+3SGzjKp3R1et+T0iLifKs3dXns4KnqRvq+8VqXdTc46fRezPR4zUMZ2I+d1nA4Jg06/5iCmgUYGKD3NhqomaSAxSqbR9UZH741WadVOfIGZfrfVfL9jECTi7jXzOYOMaJTMxOnUe2h+fNU+40l/LQ6rpWw9wTr4DJy2PRFR0Rw227T5NL9ZtcPv5+YDrozE46d/kuwDX49Wu9MPNy5VlAhM3gM0PjcHXW0WOZIFnD3G61AdZjCn5Qq6kD367tJCPSF4rD6Z5wLIWJMxiopDAx8xMQszgyPj9sDJqp6TQ9BOrhLJJZlv7v5/iLCP4PxKguSBXFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U6zBAwD66Ty+zoFkZc+lH/c9ClBKViS4ZHi+hrn0oi4=;
 b=NzUI2whUucSrrFqq94lQ5mKGXsA8/Ii6SQQjto4ET69Ygz950TzAYc9QjFPJ3gokQvQN9c44cCGu6MCiUxz1o1hAcdG53bcFvMHKYf3nHMn4+hQeV308VB0F9B/07uPBi1vVq9mwJ0e10SvWDrh4Fsc3R2PcRKncoKxWfRm4cprdXJHoJJgj6UL/+io3FG0hiLUhw0A5TtnH9DrtJxGCgFVGTrX1Mq2EJY8mTsgM+IC5SCJHIpz8MWgLrsKxPBscoj0PoADYSjjVqq4BNf9yobn+9IYMdOoKQCbxI8L92dfdGfRqBQYJZ41ZSFmGKbs+CozS8b2mM3A1ZzKqpQmaFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6zBAwD66Ty+zoFkZc+lH/c9ClBKViS4ZHi+hrn0oi4=;
 b=RTf6HjzHXFbE8a4Htlg5Eu3oIj3nEafHvbv/v0589DQepg04IEp6NpE1Va+JPU+pQ3S1cESvT/GjvIDbKNHN2S/Hb/xE/N6ec4whzNOGH1kSe2VLTUJJXGZraeAAoxTmqjWoDbkA8JB9oCg1J6qDGF3a9EfTPnOI7bc+szugRWjurTw0ulw6ldMiSvCNjk2kqh2zLhYBodGEe28bQxhmbKK7fqTARxXC3mDd9/SzrZFcH0zSfwnYR0EVy1dUj+HIfbyAd1DN0FmL+RzbTuC7evBiXydgpkMFg8wkY6mTVDOjk/8/28lrnV5rt8TeGZoD9LAcVU7OWfzfWWqa/SaKdw==
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by PA4PR04MB7856.eurprd04.prod.outlook.com (2603:10a6:102:cc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.16; Fri, 22 Aug
 2025 09:07:09 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%4]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 09:07:09 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Frank Li <frank.li@nxp.com>, "jingoohan1@gmail.com"
	<jingoohan1@gmail.com>, "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 1/6] PCI: dwc: Remove the L1SS check before putting the
 link into L2
Thread-Topic: [PATCH v4 1/6] PCI: dwc: Remove the L1SS check before putting
 the link into L2
Thread-Index: AQHcE0D7DlJ6SluNCkOW5xkD9gHa7LRuYPoQ
Date: Fri, 22 Aug 2025 09:07:09 +0000
Message-ID:
 <AS8PR04MB883352DA4438FE33A5996F6E8C3DA@AS8PR04MB8833.eurprd04.prod.outlook.com>
References: <20250822084341.3160738-1-hongxing.zhu@nxp.com>
 <20250822084341.3160738-2-hongxing.zhu@nxp.com>
In-Reply-To: <20250822084341.3160738-2-hongxing.zhu@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8833:EE_|PA4PR04MB7856:EE_
x-ms-office365-filtering-correlation-id: 019ab5bc-5028-403f-3b2b-08dde15b466c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|7416014|1800799024|366016|7053199007|38070700018|921020;
x-microsoft-antispam-message-info:
 =?gb2312?B?bzBvYllaQ2dzSy80aEtRZGpSWlprVlNya2ZxNE9zd214NTV5Z2JDY0s0Zk1G?=
 =?gb2312?B?U2hJYzRFVkJDZWpKNnkxc1R2aXljUVk0emlhYTY2RnR5NDBrRmRyU1IrbVpX?=
 =?gb2312?B?S0NIVWhjQTF1ZjVJSXI1UzlmbGlQNzVQYU5WRlk5Rk96UEdkYkZYOTE5VzM4?=
 =?gb2312?B?S01ScmtselQ2ZGk0U29TNG1lQlVVZHlXUUY2bzhwbndhTk9YZTVoQ0QxL2Vt?=
 =?gb2312?B?TmM1bHZUWlVnNnhtT0prdmV1azVzV1hzUFZCVUVIWmo4ellzVFNGK1pJYzFR?=
 =?gb2312?B?T2o0SzJhWkJNeHhSOEVtV3g0dG5rUEdXRU5XdEw4OVNrSkE2NFNNZlJIZnJF?=
 =?gb2312?B?UlFsaFJMVWVzdW81VVJQQm9KcmZQdnZOdEpIRGRoWHBmUzFRT01mWHliSlov?=
 =?gb2312?B?N3JpQlVud2pjZ0hOOHd1amhDS2YvRk9yaWgyQ0hNRGkveCs5U1dQdnRRNEFQ?=
 =?gb2312?B?bXlYVjBybzNwbGZnS2xGUDUxM3RIejZKT01OcFVCUGNzNWNIVFNyR3UxcVYx?=
 =?gb2312?B?c0QvMk1FbStBemlnYUZQeHI5QXpLR0tVaFlTOFhaeXdLTTk1bW1JQnZQVkpO?=
 =?gb2312?B?dm1mSDRFZDdXY1FkbVlsejR3SFplRjhJYXN0L3prb01MeGxCRVBnYzl2VCta?=
 =?gb2312?B?djFaOGZrWFBsU244ZWhBU2pUd2x3TlNDeDBydmFlSmNxaWVYdTVMNmFLZGZk?=
 =?gb2312?B?dXFXdjkyWTNQUlltYzk4N3ErQ1FzU09qZ29CYWp6Y2ZSWGdnT05JV20rRlpv?=
 =?gb2312?B?VVJYUUhObVhQVGNpNngrNWJobmpoRWRheVBCRjlBVE9OTDMvM0JXNmZRS3ZF?=
 =?gb2312?B?T01VNzF3UkJEMzZaU0hzQWJGVUlmaHc4QzFxNVB0MGZDbkY3OWtHMjhQQ1Vl?=
 =?gb2312?B?c292bjMvWDZkMU5XaXU0TGtDemt4UzRVc282V2czOFVNSEppZEFXaW1XcEdV?=
 =?gb2312?B?dmhESGgxTTVSdmhINENQTmtJcFk2TlhuemRxNnB1TTh5Mm02eGxhZzd0aHRj?=
 =?gb2312?B?MjRYRVh6TkRRd1RiSzlNa1FRREVVVWZKMStLNmNNRU9RRjhHa28zdVBhNUJU?=
 =?gb2312?B?YTFNM3NmOVh4M2Y5eTNvTlhUM0VKRndOQTltQk1CSjc5MTdiMXBqN2xIdVVY?=
 =?gb2312?B?L05LT3AzdDhiQ2wzUkNENWs0LzU4ZUxxVTZ5Qm40L3JvbFg0eDlMazIzK1dF?=
 =?gb2312?B?anQzSzlGaWpMS2p0dS9MR1AwUkhueHk4L2UzbTdGSWFPaXg3QVQ3bytUYW5J?=
 =?gb2312?B?Sy8xU1BCanlmM2FsMGRPTU43djJGcFl1QTFTL2xFTTNsbVBabG9wRVNqWXVi?=
 =?gb2312?B?MTViTVZUQXF4ZHRaRXQzZEZRWU1QWmd6V3ZMTTF5M3VKYWdCTnJqMHptTThH?=
 =?gb2312?B?Zm9VYjcyRklUaUI2bWtJN3JBUWx5L29FVUdLVUJ5cUlueGFzaTlpQnlzSFZx?=
 =?gb2312?B?bVMwcThvZXQ1RDdZcTU2Vmlwb0ordU9iOWdWUG5NaFQ5U0drZXRoa0pwS09Y?=
 =?gb2312?B?d3JsbUlpZmRYMTZMWjhsaUpWd0E5YjFqTlQ2cDRnOFZDS2FvK3ZmTU1DU3No?=
 =?gb2312?B?NWdKZzFYZ2NuV2hSRXRKWnNYaTZKalhpbWZqQkUwNGN1SVQwVkNUdS9EM2xy?=
 =?gb2312?B?Y3F6eFdLYjZFc3k2UU8wZVdDWXdBUDRHWThJbGxrMGRzTkt0OERpUngzM0VL?=
 =?gb2312?B?YVpraitRWnlqdUhoVklieFgzU3RxeVgrQUNZN2VuUTJVNkowcmczY2dtZVdM?=
 =?gb2312?B?aFU3SmFUdGZTdnhBTE5RQWxDRWpmZ1c0T0lENTJ4SUhpa3h2SFpBNnFmaW5u?=
 =?gb2312?B?WUs4UWFOSHRCcEFDb1gyczkyZTJrUHRCeFV5M2NjV1duNjhhbmlJTmV0cDRj?=
 =?gb2312?B?VWJxVjBnV25CRm9xaCt4dHRzMG5LQUJZdXhseVVtckpxWkRzMWxIci9BSnJp?=
 =?gb2312?B?RFFCK1EvVTJQR3crdis5aGMwZHN6b1laYzlIcHNyOGJkVzlLckNrUXRMLzlU?=
 =?gb2312?Q?Iz9BWEyboIjhY4QTvMPn9N8xVpa5y0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(1800799024)(366016)(7053199007)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?ZU5jbVBuM2I3TnpiTzBFRFJzN28xM2l6NDVWbnd4azBCRVZRR2ZmcDVRK3gv?=
 =?gb2312?B?UkxBNnVVbGYyc1NmSXVvaFphbnhtTzlxMnlSRjBuaHZ0STd2MndRbmNkQVQw?=
 =?gb2312?B?SDdPVE84NHZPbUNMdnVlUGVXa2RTdDlQZVY2NnR5R1I0M1RFaGN6L1gvSktu?=
 =?gb2312?B?UklOdEl3QjlxSE84UUxDTzhROVFUY3hLbEF6emFDY3k3SWZhZk0vL0RHMzFB?=
 =?gb2312?B?dzRMUDZaN2V2bUdLeTU5d2dtcTlMQXkweEhyZFRUYWlqR00vTm41Z1ZveFF4?=
 =?gb2312?B?WGQ0UFplTzFFQ0lINXdvZ2tJbmhLYktzL2dBQ1RtVWpkYmdGYjB2MmZwdzFO?=
 =?gb2312?B?UXRURmR3OVdFVUFGZVAwdllQY3ZuWlBGaXd5RnlNSzR3dTMza3Z3R29tVUQ4?=
 =?gb2312?B?OVJTWVZsMFgvVGo0eGtFN2hidDVRbW4rYVdqV0pGdkJaVEltcjJ6eWNOMmRW?=
 =?gb2312?B?dTIyVlhxbU5ZWlVIWXRBT1BhZ1h6YkhBZStxaTRIWWdPUnZsS0VnSUFGU21y?=
 =?gb2312?B?WnFLRnJ6K2tHemlvcU5SUVVrQU9jTzlTMjNnbmlhRVp1K0xQaDhmZHZKWjNJ?=
 =?gb2312?B?cDNCcHU2cVBNcTh4SzM5bTBtQzU2K09rbHdRckM3UEUzcW4xRS9jWkhqKzNN?=
 =?gb2312?B?SDNUTkRxaHYyVVllU2VqaXZuSU5VTnhOUlowSjZQRGx0bXNtTWtYRDZJSXNM?=
 =?gb2312?B?bFVSSW5MQks1VXJtSG5IWXQ5MndtTlhjYlVaczJkcDdualRDSEgzblA1SHlP?=
 =?gb2312?B?TTlQeCthVEdxY2oxR2h2R1gvcTUxTzQ4VzBvTm5KOXBMdEdlMUNhWGZpMU9P?=
 =?gb2312?B?VnVzdnJHYVk4YnJ4d3VsdkRRQVZ0bDZBUnRON1ZmMjh4NnpWcW91RTludkpU?=
 =?gb2312?B?T2JJSDIxTWxXNWVjMUdVSmFTK2ZMVFlUenREMkpzeDdDTnlFaFJrUkE2NkUz?=
 =?gb2312?B?VDBkYnREcys4dVczclRkZTl1bXJrMDlmNDhTc2Z3L0RRb1pjSnZmTnpzN1Bw?=
 =?gb2312?B?TnFCWjIvaVJmQUIySGF0UktmM1pGSjBqUFJYaEJiSG05cVlIcXpsYWV5Z0c0?=
 =?gb2312?B?a2hmZGd1anh2OCtoVDRxNnFFQnA3U2N3K2dvTFJZbUxFNmNDbXlHMUhMcTZk?=
 =?gb2312?B?SGIvWlFrWWFjbExQQi93aUhXL1l0QlBmcStLbjh4WHVmQWE4eWI4Ynp2Q2dC?=
 =?gb2312?B?MkhXVFp2b2xUb0FjVUxQYTdobTl5OHZRV2lleXBUcHM0WU1lazdXSE4raDFV?=
 =?gb2312?B?Q2JXeGd2bnppSGZrYjg2T1dlZzVCbXkwZlVlTzNzeGJhRSs0WjZ0QndOQlA3?=
 =?gb2312?B?WGlyRjh5eE9SUnVIdlA2VzFyTHBCREZQZHp1RHRxQmRXekJFUHdLWGpGUHpZ?=
 =?gb2312?B?aHhPSTRkZHNrNnJ3RDF5Ri9LdEZQQTRkMjQyU2JGRVY0bWgyeGQ2VFgvajJ3?=
 =?gb2312?B?SHJSMUYzaDYzdVFyeTNKZkRyZ216MDJvNWY1YldpSEw1MmxKaDNsQVBidDJq?=
 =?gb2312?B?akYzV0xhRk5NZFIzbk1jZWtOV05ZMUx3Qko1Z3BPOWU2MHNTUVE1d3F5dEV0?=
 =?gb2312?B?QTZBS1htZEtuTldjMWVYbFE4VWtpR0Evb25wRlVOR3FnUFZEaUcyTW12YWVQ?=
 =?gb2312?B?S0JQQVNZVkcySmpFUG1oVE5TeElXdmFtbjlJVC93cWw4dFZ2VzRTd2hPVEF4?=
 =?gb2312?B?eG5kYlV3ek5nY1Q5aHlXbTVtaFZ3bnlydjZ4YVhPSENJUEFJOEUwNzNvMVhp?=
 =?gb2312?B?YmVMYy9pQ0RzMTk5Ukw3YUZ5UXpueGlYcWhwVUN0WHczcGUzUmxXUitYWThZ?=
 =?gb2312?B?THRJNGVPR0tEZGdFd3RLRlIyaVlTQmF6U2FOSnREZ1ZIS255K1pQdjVUSmZ3?=
 =?gb2312?B?bEVkN09xWHJ3UWR3TXpYby9IK2EvNmxVZC9EUy9DVnNjVUNLK1U0cGJoVGhP?=
 =?gb2312?B?L2liejR6SjRuV0hDTmlBMGdPRUwvK3puWHM5ZTRqQlg1eDRYWUttMm9XM1J0?=
 =?gb2312?B?NUZQSG0vakpaMnRic00wZ0lrVUpVMDFzVWR2bEtETitUaTI1V0NaazFGM1RT?=
 =?gb2312?B?S2puUm95V3dVK1ExVDJ5VjgzQjZRMDRVS050a3pWNVlhVjdzblhYY1lvTExB?=
 =?gb2312?Q?Vw6c=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 019ab5bc-5028-403f-3b2b-08dde15b466c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 09:07:09.5555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6i9L5h9pUTlHjXo/3zPFRexwE/EI71SB44DdF6ZwbmOL1f9b1njV1C+ew/qDL5K7Cqe4IzLxMfUmKzH5Y2nRjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7856

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIb25neGluZyBaaHUgPGhvbmd4
aW5nLnpodUBueHAuY29tPg0KPiBTZW50OiAyMDI1xOo41MIyMsjVIDE2OjQ0DQo+IFRvOiBGcmFu
ayBMaSA8ZnJhbmsubGlAbnhwLmNvbT47IGppbmdvb2hhbjFAZ21haWwuY29tOw0KPiBsLnN0YWNo
QHBlbmd1dHJvbml4LmRlOyBscGllcmFsaXNpQGtlcm5lbC5vcmc7IGt3aWxjenluc2tpQGtlcm5l
bC5vcmc7DQo+IG1hbmlAa2VybmVsLm9yZzsgcm9iaEBrZXJuZWwub3JnOyBiaGVsZ2Fhc0Bnb29n
bGUuY29tOw0KPiBzaGF3bmd1b0BrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBr
ZXJuZWxAcGVuZ3V0cm9uaXguZGU7DQo+IGZlc3RldmFtQGdtYWlsLmNvbQ0KPiBDYzogbGludXgt
cGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
Ow0KPiBpbXhAbGlzdHMubGludXguZGV2OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBI
b25neGluZyBaaHUNCj4gPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0gg
djQgMS82XSBQQ0k6IGR3YzogUmVtb3ZlIHRoZSBMMVNTIGNoZWNrIGJlZm9yZSBwdXR0aW5nIHRo
ZQ0KPiBsaW5rIGludG8gTDINCj4gDQo+IFNpbmNlIHRoaXMgTDFTUyBjaGVjayBpcyBqdXN0IGFu
IGVuY2Fwc3VsYXRpb24gcHJvYmxlbSwgYW5kIHRoZSBBU1BNDQo+IHNob3VsZG4ndCBsZWFrIG91
dCBoZXJlLiBSZW1vdmUgdGhlIEwxU1MgY2hlY2sgZHVyaW5nIEwyIGVudHJ5Lg0KPiANCj4gRml4
ZXM6IDQ3NzRmYWY4NTRmNSAoIlBDSTogZHdjOiBJbXBsZW1lbnQgZ2VuZXJpYyBzdXNwZW5kL3Jl
c3VtZQ0KPiBmdW5jdGlvbmFsaXR5IikNCj4gU2lnbmVkLW9mZi1ieTogUmljaGFyZCBaaHUgPGhv
bmd4aW5nLnpodUBueHAuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdj
L3BjaWUtZGVzaWdud2FyZS1ob3N0LmMgfCA3IC0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA3
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
ZHdjL3BjaWUtZGVzaWdud2FyZS1ob3N0LmMNCj4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3
Yy9wY2llLWRlc2lnbndhcmUtaG9zdC5jDQo+IGluZGV4IDk1MmY4NTk0YjUwMTIuLjFlMTMwMDkx
ZDYyYTAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVz
aWdud2FyZS1ob3N0LmMNCj4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1k
ZXNpZ253YXJlLWhvc3QuYw0KPiBAQCAtMTAwOSwxMyArMTAwOSw2IEBAIGludCBkd19wY2llX3N1
c3BlbmRfbm9pcnEoc3RydWN0IGR3X3BjaWUgKnBjaSkNCj4gIAl1MzIgdmFsOw0KPiAgCWludCBy
ZXQ7DQo+IA0KPiAtCS8qDQo+IC0JICogSWYgTDFTUyBpcyBzdXBwb3J0ZWQsIHRoZW4gZG8gbm90
IHB1dCB0aGUgbGluayBpbnRvIEwyIGFzIHNvbWUNCj4gLQkgKiBkZXZpY2VzIHN1Y2ggYXMgTlZN
ZSBleHBlY3QgbG93IHJlc3VtZSBsYXRlbmN5Lg0KPiAtCSAqLw0KPiAtCWlmIChkd19wY2llX3Jl
YWR3X2RiaShwY2ksIG9mZnNldCArIFBDSV9FWFBfTE5LQ1RMKSAmDQo+IFBDSV9FWFBfTE5LQ1RM
X0FTUE1fTDEpDQo+IC0JCXJldHVybiAwOw0KPiAtDQotLS0gYS9kcml2ZXJzL3BjaS9jb250cm9s
bGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtaG9zdC5jDQorKysgYi9kcml2ZXJzL3BjaS9jb250cm9s
bGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtaG9zdC5jDQpAQCAtMTAwNSw3ICsxMDA1LDYgQEAgc3Rh
dGljIGludCBkd19wY2llX3BtZV90dXJuX29mZihzdHJ1Y3QgZHdfcGNpZSAqcGNpKQ0KDQogaW50
IGR3X3BjaWVfc3VzcGVuZF9ub2lycShzdHJ1Y3QgZHdfcGNpZSAqcGNpKQ0KIHsNCi0gICAgICAg
dTggb2Zmc2V0ID0gZHdfcGNpZV9maW5kX2NhcGFiaWxpdHkocGNpLCBQQ0lfQ0FQX0lEX0VYUCk7
DQoNCkl0J3MgbXkgZmF1bHQgdGhhdCBvbmUgbGluZSBpcyBtaXNzaW5nIHRvIGJlIGRlbGV0ZWQu
IFRoaXMgY2hhbmdlIHdvdWxkIGJlDQogYWRkZWQgbGF0ZXIgd2l0aCBvdGhlciByZXZpZXcgY29t
bWVudHMgbGF0ZXIuDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQo+ICAJaWYgKHBjaS0+cHAu
b3BzLT5wbWVfdHVybl9vZmYpIHsNCj4gIAkJcGNpLT5wcC5vcHMtPnBtZV90dXJuX29mZigmcGNp
LT5wcCk7DQo+ICAJfSBlbHNlIHsNCj4gLS0NCj4gMi4zNy4xDQoNCg==

