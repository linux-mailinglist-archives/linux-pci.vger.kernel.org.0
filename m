Return-Path: <linux-pci+bounces-5229-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BB688D8C1
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 09:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0DAE295D96
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 08:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B382B2E63B;
	Wed, 27 Mar 2024 08:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="XNjsu5DT"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa12.fujitsucc.c3s2.iphmx.com (esa12.fujitsucc.c3s2.iphmx.com [216.71.156.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CB61849;
	Wed, 27 Mar 2024 08:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.156.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711527857; cv=fail; b=WZHr9/0Btc5Zx4WSMV2Uaem3DtksLrrfnlZB+irLDPuSALMKsiXGzKM4y0XFan/WL0vojTFSZI6/UIXmrAHe5iiRCslVrK24y036LgVbwUUg2rFue0T/x5MH+YQ5ujCs6xaPVVDMBS3S5QM6IoQv+HBOs3R3uImk8uoQQoG5GJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711527857; c=relaxed/simple;
	bh=MH+ox+8ZsLzUrSxhktsxdiP9OBMqsD2WhpJEiZsB9lM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jRMCGDSSApoMHhpiCUuiVA6KtIW/nVk3Cnn+s9CZTSnTHea0GjKKr/CMjZE03NQr5gdUs0ks3S/TyquG/6xHW38xBeiNfUFr5eob+5y8MkRqyOkJMmabVc6pax/1CGeOZCATuT2Xp6d1vzO6KOWo8Awykc95EqCoZeqsH+uN+IY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=XNjsu5DT; arc=fail smtp.client-ip=216.71.156.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1711527855; x=1743063855;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MH+ox+8ZsLzUrSxhktsxdiP9OBMqsD2WhpJEiZsB9lM=;
  b=XNjsu5DThtek6gr+LoKMV5RABkD5s/PcJnrk6aGJw2KUJ9DLM4BtvdVE
   iJsrzrUeysXon/sNCIpdKyCc/DLoU3HMHmG0cNM8I3QhCcAf6VpunQ1VS
   eyt93Se0aGS8S6+p6mkQ2lT0NNOVTu582zlTkj4sZQa7Y8o5elPhCn/Uz
   EA2bp9cs4XrZw6RnE30Ojw4DrskhusV1Fz2mnN3k3E9uIUftnj6oT6jM7
   /pKdRRoc4hFylMZwHfAgevINqc1+CcNL4uczcwv+Xc8xKAyEdlg/mgke1
   FLMFXZ6J2eb6mjjWpyS3T0WbqdxZuf+ixCJojNWI4QojxKucYltZXRClZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="115359578"
X-IronPort-AV: E=Sophos;i="6.07,158,1708354800"; 
   d="scan'208";a="115359578"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 17:24:05 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IWxWVQPx0fbdq93aKLTNyEtm58LC4osuDGdyRrEI+uiATJJtpUWcxC6LVWgF7u4ftb6xbTVe8jNs1+vwNtJM7QZWwCPkuZgjZuw+wAu4H3+c8SIdzwmdhuntfbXKxNzv8RaVy82Wpf/DYe35UXqHeu7i/l4iCYYZ7/K056YmUqguiDfG6UL47iZAgfOF2VZpE7RZxXBkZoUlHhrBqNq/vsGa4mRK0ZWrfekYH0VkEQ7J6bnDl6VBR2M98Yo9k5YDpw0Xra71J17pktk8Cg8WswD+6N5mtlvw57Xxnpy/YJWlFuwyRp66e7Ve+7wQYN4C5ZdkDk3rGgVolARNqvu4Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8v5KHwiRLIRkstQC5Jl55m7FIDHBfwXw5vOSjky2fU=;
 b=g9M9KLjut/gWWRQGDgaJvTWNgZQpXQWBUVYBErz0RI+40Gz8anIWBHjQrSflfhRGQq7HYk7AoonMcwxp1pODqLaKTiJTAPqt42i3JAWuQ39GfrTPJScNHvQWOCY9TFr25vvs3XKbEk49fEYQpf9MeKCPoruEO0Lt1hVi2SbG1UXvcDcMIrqrR23RmcHdJHLN+PBxNJaGSovZ4GCTEEj5vdpPOHRdazjmZU0126ZHGGpghR+Oo4V0R+HEsWWzlkCEjZfSgX9SsGCZE7NyBzzC88THi3UOVjZqI52lGRo3bBoOuLy82u7R4JXqZ01z1Kvx7bSAaWECYE0gdgtv+io3IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com (2603:1096:604:141::5)
 by TY3PR01MB10013.jpnprd01.prod.outlook.com (2603:1096:400:1de::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Wed, 27 Mar
 2024 08:24:01 +0000
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::c012:6dff:e4f5:5e1c]) by OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::c012:6dff:e4f5:5e1c%5]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 08:24:01 +0000
From: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>
To: 'Dan Williams' <dan.j.williams@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
CC: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "mj@ucw.cz"
	<mj@ucw.cz>
Subject: RE: [PATCH v3 0/3] Display cxl1.1 device link status
Thread-Topic: [PATCH v3 0/3] Display cxl1.1 device link status
Thread-Index: AQHadFO/DLT7o3hEPUOdByLFlXQIcrFKez4AgACh9ZA=
Date: Wed, 27 Mar 2024 08:24:01 +0000
Message-ID:
 <OSAPR01MB7182CA5212FC869DA4676C86BA342@OSAPR01MB7182.jpnprd01.prod.outlook.com>
References: <20240312080559.14904-1-kobayashi.da-06@fujitsu.com>
 <66031eca92f5a_4a98a29427@dwillia2-mobl3.amr.corp.intel.com.notmuch>
In-Reply-To:
 <66031eca92f5a_4a98a29427@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=ea787c2d-abe0-409f-93db-88f210c48f83;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-03-27T04:55:13Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB7182:EE_|TY3PR01MB10013:EE_
x-ms-office365-filtering-correlation-id: 0ca99a70-939b-4883-6e77-08dc4e3741af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Hfnrtvb92h8fZzwtKDy2YHwyZxGWbqqv8ELVwksPsAZjgcAfR3+aQmV907a9mySMXwUWqD5ZeScmiPLZ1iV1ei70E+A3pCWBpG/KJPQm934y7TCc2o6MLxJ937wAULsDFW8OI95+t6Bc8sCX/DBr0spQLNn9lLkIiFlgfIjIV/I0yQDxN0jX76tnqxeiwPIVcdBXPKbGfQZ3G/AP1UQiQb7Jfp6X/FAOacvEzs3w23C6F6itZMxHfEL7bE8RjH4J13VyAi3vmm6qbe06h+rz6bybg+RBnnnVXZ+TAjDY87h7HP5U7YYt0Hy8pR+HHMm39JuUIEkLKz164443t7EA+aJTdQ/a83usOd5m6i8CnJivEwBbjh2d2CA8lZZmXBtcgDh8y0X4HLnZzF65SBWLgF7qHruzAeo1baQnxODZAeqASmgEW4Xtg7UDKzLr7rW8tvX+ygp6EaAp4Gm+FHvjIHDN+cManN2ixg16njZ/1nUhyJZ8BoxT9t5dnxZx+YUJ/CB8hYyZjmRSQNIZdiQxeMV+4qTQB5YFFEMvRfDUtH0v+NCm5i8H7MfuB0uzHfS985ICyzi2DLlzLrjUmI4rnSydtbXHaY6+UrHMkH3mC4frTvflvMo/kgtPzDnoS9aH+txXXkBIV3YjoroEwqu8y6NUOBRoXnFcgkB6LHvqkGW8mJttojMo3jS8Wk3+Ouyh
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB7182.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(1580799018)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?T2VjOGJYamFXTC9qWnhmQUhKOG1UZnFWL2dxa3Q3NFZRZmlMUyszWHAy?=
 =?iso-2022-jp?B?RHRVTmNReDVwUG5IRzFIc0tXSUtONG9qSFc3aE5WMUhyclcrRlNwdzND?=
 =?iso-2022-jp?B?bkV6MFNuUWdZREp4ektveEM5ZWZLWXFudkVmeHAwZXpUTXRpOE5xdXZK?=
 =?iso-2022-jp?B?aE5EM1ZYSzR4N3JmWVFMQUhVcU9iVm9DbHVURXlSSkhkWGlaRG5JbXhZ?=
 =?iso-2022-jp?B?S1NETW1RTnJvNFliRU5hL3Rkbjlac2xJZnNaOXpBbnE5TGtsQWxab0R5?=
 =?iso-2022-jp?B?anIvR3ppcGJrNjFiL1N1eFlFOE95MjRMZ1hkWGpwNUg4bm4yODlTbW9C?=
 =?iso-2022-jp?B?NmNTK3FudVh6MlBnSUtVRWlPZjB5aGNZWEg0S1M4TU10RlNJVWxjdC9s?=
 =?iso-2022-jp?B?RWVVb2cydWtMdUdadTlnMktEQnYzSFNZRzI2TnZhdUVXRVI1bXRmNkRl?=
 =?iso-2022-jp?B?VlJQVHhRdUg1ZHgrRDg1VjJ3S0pjRk5JdXlvUDB3RXJDWG0wcG9EZ2lX?=
 =?iso-2022-jp?B?T0tPUjkyVTVqem1QcEhJMEtBc0xqbWc0S2FlREo3bTczVnErVkVCU29S?=
 =?iso-2022-jp?B?MVNHUnRmSGtUNk9SR3dWTnl5eG93Q2dteXlBUWcrMVpBUVJ2cHViUnRz?=
 =?iso-2022-jp?B?UWgwSjA2Q2lBSy9lK2cyNEg5SjhTMFJmK3QyOUdxQngwYzhzcENZR1No?=
 =?iso-2022-jp?B?eDRlS3J0YzNKZ1ZZdWVobWFQSHZPMTNFVHBLVm1wVytlai9rc3Rvcys5?=
 =?iso-2022-jp?B?OTVZVTNCVDVJbG9lbnBYRkZRQk9NaEFDWXZGYVdBWnpqeVZ4dUlmazVJ?=
 =?iso-2022-jp?B?SGcwaDRJMWovQll4RFJNRjBMZHRiMEhkaXZzblhDNzB5ZmtsSWxQRE5s?=
 =?iso-2022-jp?B?L2V3RDZxU2lPUGFpbER0MEgwVW80RFAyaFQ3NHdweFNtbEdKVkI4OFlv?=
 =?iso-2022-jp?B?M1NQc09SdWwyOEkvVXpnaGxWL3pFaFRpMW9DT2l0RTVPVGllS1R6bk9O?=
 =?iso-2022-jp?B?aFRoR2ViUTFwdGw3R1VUTzVoL1FtUlhFMzZvQjJTNU9sTHZNTFVWUGtB?=
 =?iso-2022-jp?B?b2haVWxDclRXRTQrSDJ1MmkrZkFBVy9hdm56UU1CUG9TNjQxRmpzYkd6?=
 =?iso-2022-jp?B?MExsWWUyMXkvQ2R6V01xY21MNGZ2WHdSRlVEb2IvWmVoamlHS1VWMGQ5?=
 =?iso-2022-jp?B?Y0NWaUowelpIRnVzQUV6ZEtDRDBFZW9la2FRRU5IdCsvSWRxNlNpcEQ5?=
 =?iso-2022-jp?B?ajFkdXNKRkdncHlKY0dRUjZlMU9JZXc0MFRtT0Y5OVNZckZrV3V2M3Yv?=
 =?iso-2022-jp?B?V1FDNy9OQzNCeHVWNTZhdHBTcXNFb1RHT2xNUUxFcVM3d3phQWVhODNI?=
 =?iso-2022-jp?B?YTJ4WkpwaVRjRllnTTZ0Z0RuREtyUFhScXlNMUdXWmd0aEpYSUlBUHlx?=
 =?iso-2022-jp?B?MnJDbm5aYU0xdnlySW1UeFJvUnpXZVdOWUd1dktqL3J5dHZvQUtuVm8z?=
 =?iso-2022-jp?B?L3FQUklXSjR1WUZJeHl5MmtSbS9kWXJJSWZ5NWcycFl6MnZjUlB4QXQ1?=
 =?iso-2022-jp?B?c3V1d2hMbmp5Sk8yUk9jMWdkY3RhVVRWTXZyb0ZRbmZuT3lGblZUQjVa?=
 =?iso-2022-jp?B?NEZjbUtBTmJGMXF6a3ZTeDg3K2JkQkJ6Q2ptWFlzOWw1V1hqakNYN1VK?=
 =?iso-2022-jp?B?ZFZVd09WbDVmMlcxTEpaZGNybExsUnFzUkh3dXhmWWhKQXZBcGRRNXlx?=
 =?iso-2022-jp?B?OXZTVDhxTkZVTHpublFzS05JK0dtZERRTHZCV0dQajBPMlBCdDRxODgx?=
 =?iso-2022-jp?B?ZCtCMFBvTEhwVU10a2JWTFIrSmYremZYNzNUYXhtZ2Fwb29MSXpKTVZi?=
 =?iso-2022-jp?B?RmJHUnZoVU9DV3ZiMklsWEVpVm03UEVlNGlrMkZtZzhhMnMzSGtwdnor?=
 =?iso-2022-jp?B?WG96cDdCblNTTTRDRDFBL2FRRjduNFZubm1CdTlpNG1QTDdCcjN5VDRt?=
 =?iso-2022-jp?B?dktaQ3VObXZXOVhzaXQ1WE5mV2NjVmRTczEyREo4Q3ZjYWwrUjhCeVFT?=
 =?iso-2022-jp?B?d29IQnNSU1duWjBYT2oxYlBKZGFnUWkzNE02YXBMaThGdlRnalVaZU1h?=
 =?iso-2022-jp?B?aDN1K2dsQ3B1WmNBU2lDcjNIWGpaMVZCRXNUcVlqOXoyTFFJQ0R6MmVp?=
 =?iso-2022-jp?B?SDcvNHBDZlA5cnVWTlhhN3RnY253cS9YK3FWcTArcUdjUVlaT0JQZlJP?=
 =?iso-2022-jp?B?OGpRQW5IRkh2SHZKdDRWQVlOMWd5NkwvVTIzSUI2d1g4YTg0T3l3NFl5?=
 =?iso-2022-jp?B?ZU9pN3owS3N3MzMvQXJYMGRSRnhSNzBzZXc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JmsCVQduf9uChswmV0kuThTGiVd/V9eFYVWUmJkPcsDiWuT9VXSB0JDZsy/cZjABzOf2uLrBiUf1wPRnMgG7JUjlw6FuEiZrdehZUM0Hgs9X5SQQ/XUvMGHZT8x25GfmwHVwXDBUFNpbG5bR00ufoa0zGA2/WX4GrN0YtQan3PF8/CDLBP8CDfJBWnueRNSEvKyM1HAGyZIHrfodXFzWDkzCZT9DIHMzb+9QCBcKvQmGuUPdsxXpuEjX3Orr4gTR8m6EhsCPWYljxv1Iy55AScg2Wdy85ugdAlVYrgC/GDcpI7sTc4yqWROigJ7JoNb/nfXnkL6JLRwV/u5rvg3hncN2u9LF/c2gkLdU3DFbpOIXtkKZBWN4shiywdDKesz+b7xPwC82LLjV2eu7RRpTpV8vU1NH11MSwLo11q7rG10fvjZ/oiHr764XGNLVVcaMCu2l9UAo3PTmuL42LN4GKrWsGqckZWdYYcisc/sSsx/655bZDxufGoG1jOaOzBZ+yCqzzbDAzvBFY652EbpEFRUuAxILXyyalrU6ibiDOzEOmAV//qUdwo7TqxKEEEC6BWWslNclbpD/lSwqEdhEV5EcsIl3dct96GiS+pzNQtfj4YVq+gGhgau2aUUXXQqE
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB7182.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca99a70-939b-4883-6e77-08dc4e3741af
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2024 08:24:01.1827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Me0vtP21fDE7xyLyIos+D0QV4aGW48x+m1BsHXYmGRJesYeHQ4CdS60DvS6bwaRFT8QaY506xxkYzu3rDEWOL3pmW/ES1G72yW3L8vi4WIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10013

Dan Williams wrote:
> Kobayashi,Daisuke wrote:
> > Hello.
> >
> > This patch series adds a feature that displays the link status
> > of the CXL1.1 device.
>=20
> Good write up! One minor feedback going forward is to drop usage of
> "This patch" in a description as that is self evident.
>=20
> > CXL devices are extensions of PCIe. Therefore, from CXL2.0 onwards,
> > the link status can be output in the same way as traditional PCIe.
> > However, unlike devices from CXL2.0 onwards, CXL1.1 requires a
> > different method to obtain the link status from traditional PCIe.
> > This is because the link status of the CXL1.1 device is not mapped
> > in the configuration space (as per cxl3.0 specification 8.1).
> > Instead, the configuration space containing the link status is mapped
> > to the memory mapped register region (as per cxl3.0 specification 8.2,
> > Table 8-18). Therefore, the current lspci has a problem where it does
> > not display the link status of the CXL1.1 device.
> > This patch solves these issues.
>=20
> One common way to rewrite a "This patch..." sentence is in "imperative"
> tense, so for example:
>=20
> "Solve these issues with sysfs attributes to expose the status
> registers hidden in the RCRB."
>=20
> ...i.e. write the commit log as if the patch is commanding the code to
> change. You can find some more notes about this here:
>=20
> https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#patch-
> submission-notes
>=20
> ...but really, this cover letter is higher quality than most, so thanks
> for that!
>=20

Thank you for your kind feedback.
In the updated patch, I will revise the text and submit it.

> > Kobayashi,Daisuke (3):
> >   Add sysfs attribute for CXL 1.1 device link status
> >   Remove conditional branch that is not suitable for cxl1.1 devices
> >
> >  drivers/cxl/acpi.c |   4 -
> >  drivers/cxl/pci.c  | 193
> +++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 193 insertions(+), 4 deletions(-)
> >
> >   Add function to display cxl1.1 device link status
> >
> >  lib/access.c | 29 +++++++++++++++++++++
> >  lib/pci.h    |  2 ++
> >  ls-caps.c    | 73
> ++++++++++++++++++++++++++++++++++++++++++++++++
> ++++
> >  3 files changed, 104 insertions(+)
>=20
> The typical way I handle cases where I am updating the kernel side and
> the user tooling side of a problem is to post the kernel changes and
> then separately post the user changes with a lore link to the kernel
> submission.
>=20
> For PCI utils I believe you will need to send a separate pull request
> via github once the kernel changes are accepted.

I understand that it=1B$B!G=1B(Bs better to post separately.=20
After the changes to the kernel are accepted, I will submit a patch to pciu=
tils.


