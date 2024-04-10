Return-Path: <linux-pci+bounces-5998-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 758E489EBA6
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 09:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 273642833AB
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 07:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E373C13CAB8;
	Wed, 10 Apr 2024 07:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="xCtv8Qzs"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa4.fujitsucc.c3s2.iphmx.com (esa4.fujitsucc.c3s2.iphmx.com [68.232.151.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9FF13CABB;
	Wed, 10 Apr 2024 07:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.151.214
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712733339; cv=fail; b=Plm+bimoVB3gW3gErmBLXqwb/rIzfyv8v5OSLdhFRubm0Kmt1VpwRApc7a3Itiv4BvQ6wm3TwlQUMDt1a7sz19+sQnMAxJ9P07zEBB3KhFkOpRfCszenebozE2hCOb18z87a52sEKkVuufIT0YdFVVcFaRMWm+c52zzw+3LVBQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712733339; c=relaxed/simple;
	bh=NCJOLKw1qzr5AqpkST9zKrjI4mQwmWAvhUZMqp3SAg0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M49XE+1au6QM8CCuXm1tBjynzRk1xRLXg4bQl+OhIAo1My/F5HHP+9+tQqYMVOHB5Bql7Z48ian2cliyKmWVTVUY6ogSjXo0e+kFGGve7WfP5GmLpvxZQDlxR+vdd+Rcu5ZQBw7TFl5MawDKFXOrpMsD7UP6+KEDpbzaYfGw71U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=xCtv8Qzs; arc=fail smtp.client-ip=68.232.151.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1712733329; x=1744269329;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NCJOLKw1qzr5AqpkST9zKrjI4mQwmWAvhUZMqp3SAg0=;
  b=xCtv8Qzsv82Qpcl+jSEZv2kY0ottBNH7BMD003LoG/Ow37WWKGA2qMSp
   t8hxALkM1mkWjMFytDi3grPC9u5F1TQ4KK62VeTbzuKsCFRSbsKtQo+hm
   IAKdcVLYwFBu0M0yhX1en/o+4t+lwrrEiWz6iHnzJNEsWoJ8sZhDHAopF
   50++faaAE4F0ZU9AILiWyqURNL1Ohxa52ZnzYrPyuQJndWm8Mt5z23IPt
   I0q9nir+Fc6y71s6FxGFfshSR4HBtC2a1sCk7Iax8mcZ56qWWxId1J3kp
   ZCUFlZvh0lNJS9z48fqzANWHNX8AT3Kq1Y9DOFljGtqoY+VJeDvwVcNyK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="29433072"
X-IronPort-AV: E=Sophos;i="6.07,190,1708354800"; 
   d="scan'208";a="29433072"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 16:14:06 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YGxvQbd2XEwqKoAFQFZaBkH6+axzbC6DitYZNp5Ro0BmRUffDoJZ67iC4O3H3mHdIsBEXfr/lxZFjK6SO/arMyMmN7TlUMrv2SKNgTCw7V6hzUkf9g7iFRkoYIzfyIOWch68+pqECLlXtqfTEnnbpzHtwTW6P5yfK/1J86Kj/kR+6nClomYEoNcuwUJY+NXq0BdhMyb6GuticG+cCw5z0/u5591QHfFStnAfbKp6C32o0Rwa2LoKTWbDkSf4deiAGPzpTQVXSzvgaq+LEsdKU2h53iutqhVYIZ46M69l63DCtE1jBNI1a9/ZR8d4DaukrgeZs9xFepI5wxfwmtzfiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCJOLKw1qzr5AqpkST9zKrjI4mQwmWAvhUZMqp3SAg0=;
 b=iQMcd259ZE/+z25Hp3VYBQHj1zI6CTVPhgTX6gVu7bQb52I0pWOB++pTaYFPJ/vMxnWTM+f3LgkbQ9QvWsSJoMHME/iJXeovtXoTzP3QfoptYzIUXCo8SrdrSEDocqTdnpxbfUcVInuOXhVLv66uIGWBRQ24ia85hxaf1j4a9aNci7a+j3ONGbl2DOvl66C86GRI6Olxphx3tFor412MBl+1IO4dL9pSFMWMNN5RnXngeucD6+qFMVKrN1KjtG2b8GFy8lfOPZdFoaqbJlvLptIlIx9LHeAP+4gpnw1/wEx3YQ+MyoHTl8u5bLtObsl3D40z85fOGrm3kwMKevoVrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com (2603:1096:604:141::5)
 by TY3PR01MB9916.jpnprd01.prod.outlook.com (2603:1096:400:22a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 07:14:03 +0000
Received: from OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::c012:6dff:e4f5:5e1c]) by OSAPR01MB7182.jpnprd01.prod.outlook.com
 ([fe80::c012:6dff:e4f5:5e1c%5]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 07:14:03 +0000
From: "Daisuke Kobayashi (Fujitsu)" <kobayashi.da-06@fujitsu.com>
To: 'Dave Jiang' <dave.jiang@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
CC: "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "mj@ucw.cz"
	<mj@ucw.cz>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>
Subject: RE: [PATCH v4 2/3] cxl/core/regs: Add rcd_regs initialization at
 __rcrb_to_component()
Thread-Topic: [PATCH v4 2/3] cxl/core/regs: Add rcd_regs initialization at
 __rcrb_to_component()
Thread-Index: AQHailA0Un0IiwjThEGYnV5alDa917FgUAoAgADHMoA=
Date: Wed, 10 Apr 2024 07:14:03 +0000
Message-ID:
 <OSAPR01MB718246E0D06276B7F9C6F58CBA062@OSAPR01MB7182.jpnprd01.prod.outlook.com>
References: <20240409073528.13214-1-kobayashi.da-06@fujitsu.com>
 <20240409073528.13214-3-kobayashi.da-06@fujitsu.com>
 <519bf934-840b-496d-9a5e-7b183c5be258@intel.com>
In-Reply-To: <519bf934-840b-496d-9a5e-7b183c5be258@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 =?utf-8?B?TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5Njgw?=
 =?utf-8?B?MmZfQWN0aW9uSWQ9YzU2ZGI0NDItOTA3My00MWJiLWFhMjktMmFiNjVmOTE2?=
 =?utf-8?B?Nzg4O01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMz?=
 =?utf-8?B?OTY4MDJmX0NvbnRlbnRCaXRzPTA7TVNJUF9MYWJlbF8xZTkyZWY3My0wYWQx?=
 =?utf-8?B?LTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfRW5hYmxlZD10cnVlO01TSVBfTGFi?=
 =?utf-8?B?ZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFkNTUtNDZkZTMzOTY4MDJmX01ldGhv?=
 =?utf-8?B?ZD1Qcml2aWxlZ2VkO01TSVBfTGFiZWxfMWU5MmVmNzMtMGFkMS00MGM1LWFk?=
 =?utf-8?B?NTUtNDZkZTMzOTY4MDJmX05hbWU9RlVKSVRTVS1QVUJMSUPigIs7TVNJUF9M?=
 =?utf-8?B?YWJlbF8xZTkyZWY3My0wYWQxLTQwYzUtYWQ1NS00NmRlMzM5NjgwMmZfU2V0?=
 =?utf-8?B?RGF0ZT0yMDI0LTA0LTEwVDA3OjEzOjEzWjtNU0lQX0xhYmVsXzFlOTJlZjcz?=
 =?utf-8?B?LTBhZDEtNDBjNS1hZDU1LTQ2ZGUzMzk2ODAyZl9TaXRlSWQ9YTE5ZjEyMWQt?=
 =?utf-8?Q?81e1-4858-a9d8-736e267fd4c7;?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB7182:EE_|TY3PR01MB9916:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 RcOYkNPlTyJX+XCbmjKuNIhVSbZEXtzhQx/6NMmg8uffvtRw33SzHS8B9/KbPuJEk83ThJ7L2YkKLdgap5lh7HkrGDc8dD7diSZFpIeaUnwQ1zFEqZQwIT0h8z/eGl3W+lo60Y31XmSzl88LXP0cnu8equsq6VojY87q50Q3CchFxpe9EnxhvyjdYRqY3GEolIgGLPzy/7tjBw1HSFkP2y0yR7p7gJydp8jZj0uKJ19W/c2XcH95dSu+tVZiLr9ymRl10Wc5rSvJPQ1FH4w1z9CfxyP7SDjjEY7NZ58urVY0zR4fyzUP/NVTDZTvRS5cRpvmGCI5VS8P/JzU5zsm56nk5H8Y6OmTYFV6KK/z1FqmTIUd/7MG1iOqcS1l6xS+/rw5YbOUBeWmd96M8HmDXCII4t6TS/o/cu1Y/8yQdn8Yw2Bn8QXJ61088PYZJGkr+OzJDSrPJdYHYksEmysyLhr0+HVb8cBJ+sUijSjUdd0t4+L1jdUGxVyOyM6A27+auPGFkBpBKwUCgFWKAWUCEtbH+bO5VW61GWrFlDEfDsndRXZPPl1kAxHuKbx/0W5rw/wblRq5Fwi6kwEXbmy2kiq1+4m56MhNA8jXCmBp91LYpuWfzwkV28dd0xlGjg6BanzKYlfi1ZRGH+E4hE8YSGWV5zylrWgq+/nPBSTlzrbGXo6PD+OwEbDSjs4m/CZD3fcipUnpZd+aaCVASDVvow==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB7182.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(1580799018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZXlNOHh4bHh1NWQ5aGx2d2NYVnlZYTcrTytqUkl4dW5pZFRVemVQUjg4Um5x?=
 =?utf-8?B?Wm84SFU5NXJDTU5vRzUrME5vT05udVlEemlEOXM0aEJzVmszeXBPWFhnV3NS?=
 =?utf-8?B?T1VGd1UxWGZxUHlNSi9VTWpmeG5VTG1qMU1RWDEwSWlJa3lmTlI0a1VnR1oy?=
 =?utf-8?B?YnJsWDJSWDAvQUt0bXlPUTl5dEE3eldpUENSY1pTMHh0RzRjZG1HVVA0VUY2?=
 =?utf-8?B?a3RkRS9qcWpLQkpHYkE5eVk2SWdtSWtUdWxRR1RZd2J3RXJOTFRudjkwTEZa?=
 =?utf-8?B?K2JmT0xnWS8yeWM0L1ArZ0hIOVF6QXZLanlPdzhXYXV1aWhMeXRzTWZkL09r?=
 =?utf-8?B?MDR4MFVVNzJSVCtld3M3dXJEdFE0ekE4aWJ6MFlOVlFJQ0F1VzRlQlJkTVpQ?=
 =?utf-8?B?VFRQRnR4bFVlYjNDdit1eDJlNU5tVEZZMWl6MDdpbU1vZGNRdkN0R28waUoy?=
 =?utf-8?B?a29XMHFPcmh1d0xrSG5oYmdEWjhSZlI3QXdMWVRJaHRiakxkWVFrQTIycXJD?=
 =?utf-8?B?Q013TFJaY0s5ODg3bVhHK1cxaUVKbmN1YkZmeUphbEVGK0xhb3ByUVUvSGZQ?=
 =?utf-8?B?ZTUvZmlzZ1pkZXl6Kzh6TW4vbDdhQ3hrU0pxcUZsVHFyQ2dTaStGYlUySXhM?=
 =?utf-8?B?ZHZOMUFmVFVjWklHZFNOekIxL0VhUTRwN0MrUEVyc1hHV2kvcE5sbG4wZnFE?=
 =?utf-8?B?SEY4UEpKZktPZEhrVjd5dE9UK2lFbHEzQ1RhTVRNUEo5YzJuYkVRWVk2Y1Qz?=
 =?utf-8?B?SW10M3hPS1gwbTFoc2Z3VURzUE5IcThZb2pFVGF6M1BrMGtDRjV5SWVpdGtJ?=
 =?utf-8?B?RVo3aWhpeHIvK055bzFjVGhMbG1SaFhqRFpEdDRMTnRIUG1mTlJIU0ZCNEJW?=
 =?utf-8?B?cythdWswWjZZbHVLdERENFFDN0ExUHVMdEdSRUlvVzNGaFdWTFF1U0lQSFIw?=
 =?utf-8?B?VW5FTW1pd1hsa0k0R2NsNmY1NDhJaVhXOXJsYTZIRFFaWTlrYi9WOURtMDdC?=
 =?utf-8?B?Wi8ra2I0SGl6RmRLSlphc09DWVZ5RElad3I3SWd0RzhwZm9LRk5HOCtab1pp?=
 =?utf-8?B?V1NoWW9OVGp0NDRJSDZ1NkNHK25PMFlNNUQzVVQwYm5WazdyZUozSWhJMlM2?=
 =?utf-8?B?U3hWZGRXaXMzamNzQkFaaGxtRktIc2NTN2lPQ3pmdjgxWDU3UXB0ZGZBSTNC?=
 =?utf-8?B?dDNLaWhHaXdibXpTUUFpczJyMTk0NTA4RUJXZk5rUFRhSklNSTlrM0U2UGxW?=
 =?utf-8?B?OVAzNUtLL3VyU2p3d1h0RGxHWU9DdUVKem1xNzNxUjMvYmRWd2E5SjJJTStO?=
 =?utf-8?B?NmFtMm5OU2ZxNWFRbU9VUXJJWjZmclBHSzhxK2JuTURhTFpVTzk1aGNMYk0v?=
 =?utf-8?B?VjhRYkU5MFExOHErZ2hnMjBNdENqblZGalRtMVRPTDBuZmZlUVVzaitzSGZI?=
 =?utf-8?B?Z3ZFMlM2NlpJYUx6aUJpR0VNNFlTSUtzN0k3bUNmSHpFYWdqREJyVUd3Vkdr?=
 =?utf-8?B?VUtaWmRRWnFsSzRBRzhtTWY3ZlFHbnFBNnlkN051ZzFOTDIzSlFWcWR0bWVs?=
 =?utf-8?B?cjBCVXo4NnQrZlFrb3Bta0gzamNjMi9hT2tPUTdOZXF6ZFRwUWlQeXd1OEMr?=
 =?utf-8?B?UkxvUXJNdVl3bld5Z3AzZXJDdTRHOG1sdklPNzRySmg0Nm1RVy9lZWYvTmkw?=
 =?utf-8?B?U1M1U2h0Q3lReEY4a1liSUlaTWU1aE9HSC9kVDZpSk1PdjNqQlVVVEhRckxU?=
 =?utf-8?B?RWRPTXBZQ1JVby9rVVlIYjJDQ2dQK1RXT242ZFJlVlNCUjhkdEF2Y1loZWNF?=
 =?utf-8?B?RTNpL2FXczJBWEVWTVpMNFd3KzFTTVdGWk8vK0R2dnIzTmY2UmpDc2hiK2V0?=
 =?utf-8?B?OUZGYjJPcHB5K2Q4dHAvWE92TnIxaEcwTVQ0Q1RMd24xbXN3S1lDR1ZGdXNP?=
 =?utf-8?B?S1YyNldaVmVNZ1Ztdm9zeGtqcGUxL2lTcWVhelU5a3FVbjhwQU9SL1cwQWVk?=
 =?utf-8?B?RTdrZXVpdGpyc21OdzdDRGJTZ3FUbndoN0tPWFloOUU2TmFyd2FFWnNQanM2?=
 =?utf-8?B?bXZRNmVkWmhwckFvMDNEY05HWlgyek1RTDBWNHJOM3dKV3o1WkpvM3BpRnZO?=
 =?utf-8?B?czZxQng0NlBDQ2gxbXZoTkJxeEdOLzg2Zkhrc3U5c3IrMld2bC94aTFBN3NG?=
 =?utf-8?B?N3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PAyEM3k+em3MvZinKYrxwfU25EBYm92IiWqajgh88ycZI36qaAxyec47ZvjAilKqnZoIYR0OCuYPLMNWB49qqzf+/rLZkLQfm8DXbYwhpEetLlUz+UlIHhzEkGZ+GAoE0jzXcdCU9ibZPO9JAl4+HG1Qn5rTCH5apIdEn4QjHsxIPaF9itjJBX5Xo9deHFAPAIamrxVttGUIlWdaw6l8SQELBtNvt0x9glheLNls3dkljymHwCDYTDK92vLvZl11vsVgxA/Fz7U6UKO+nLk0dd1l65yv4KHUEDlycBhy52N9ygrwFhjrinJ3unf5j+SyZiQ9VaEFRxTt8TQqsNdZ0Zk4kqCkl3yFh0Dfc6qPUuVlR9PvTpDJLMzapMznM1FazkHBLa+BqiUFcPQ+88HgfnBELbz1TjcAkVzT+p9PyBl6ZcxsrTTCTsaXFSMJeMsfkOmRwSDzvZa0skl9p8pDYQCl88Y2TIKj9WwrdOXxNaSKvHzj8+GCzf2X/T3BeKtu7sFjFFvIIcc+hTp9XAVCwOo66qjkQ0GU0eRM/dBMoEMT0W1DvWa6heJkctDDqXZNGAUkONtYSXFdMc1jGrnA+7x6Ho9w+DzFP6wUtSwnisB3vNpzJu6XF2m9KVTwFIUP
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB7182.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dcef98b-141a-4e29-4966-08dc592dcd3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2024 07:14:03.1358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MoymX7G+w+9AP9zLgBryJuVQC+0tbNP1cdne5D03t/B4A2bu6YMt1xuq4qR9TA5Hj1MLTNxrs63+Oer5hLVBe5Vmf6B5Xea2Ra87WKfefFg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9916

DQpEYXZlIEppYW5nIHdyb3RlOg0KPiBPbiA0LzkvMjQgMTI6MzUgQU0sIEtvYmF5YXNoaSxEYWlz
dWtlIHdyb3RlOg0KPiA+IEFkZCByY2RfcmVncyBpbml0aWFsaXphdGlvbiBhdCBfX3JjcmJfdG9f
Y29tcG9uZW50KCkgdG8gY2FjaGUgdGhlDQo+ID4gY3hsMS4xIGRldmljZSBsaW5rIHN0YXR1cyBp
bmZvcm1hdGlvbi4gUmVkdWNlIGFjY2VzcyB0byB0aGUgbWVtb3J5IG1hcA0KPiA+IGFyZWEgd2hl
cmUgdGhlIFJDUkIgaXMgbG9jYXRlZCBieSBjYWNoaW5nIHRoZSBjeGwxLjEgZGV2aWNlIGxpbmsg
c3RhdHVzDQo+IGluZm9ybWF0aW9uLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogIktvYmF5YXNo
aSxEYWlzdWtlIiA8a29iYXlhc2hpLmRhLTA2QGZ1aml0c3UuY29tPg0KPiA+IC0tLQ0KPiA+ICBk
cml2ZXJzL2N4bC9jb3JlL3JlZ3MuYyB8IDE4ICsrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZp
bGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvY3hsL2NvcmUvcmVncy5jIGIvZHJpdmVycy9jeGwvY29yZS9yZWdzLmMgaW5kZXgNCj4gPiAz
NzI3ODZmODA5NTUuLjMwOGViOTUxNjEzZSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2N4bC9j
b3JlL3JlZ3MuYw0KPiA+ICsrKyBiL2RyaXZlcnMvY3hsL2NvcmUvcmVncy5jDQo+ID4gQEAgLTUx
NCw2ICs1MTQsOCBAQCByZXNvdXJjZV9zaXplX3QgX19yY3JiX3RvX2NvbXBvbmVudChzdHJ1Y3Qg
ZGV2aWNlDQo+ICpkZXYsIHN0cnVjdCBjeGxfcmNyYl9pbmZvICpyaQ0KPiA+ICAJdTMyIGJhcjAs
IGJhcjE7DQo+ID4gIAl1MTYgY21kOw0KPiA+ICAJdTMyIGlkOw0KPiA+ICsJdTE2IG9mZnNldDsN
Cj4gPiArCXUzMiBjYXBfaGRyOw0KPiA+DQo+ID4gIAlpZiAod2hpY2ggPT0gQ1hMX1JDUkJfVVBT
VFJFQU0pDQo+ID4gIAkJcmNyYiArPSBTWl80SzsNCj4gPiBAQCAtNTM3LDYgKzUzOSwyMiBAQCBy
ZXNvdXJjZV9zaXplX3QgX19yY3JiX3RvX2NvbXBvbmVudChzdHJ1Y3QgZGV2aWNlDQo+ICpkZXYs
IHN0cnVjdCBjeGxfcmNyYl9pbmZvICpyaQ0KPiA+ICAJY21kID0gcmVhZHcoYWRkciArIFBDSV9D
T01NQU5EKTsNCj4gPiAgCWJhcjAgPSByZWFkbChhZGRyICsgUENJX0JBU0VfQUREUkVTU18wKTsN
Cj4gPiAgCWJhcjEgPSByZWFkbChhZGRyICsgUENJX0JBU0VfQUREUkVTU18xKTsNCj4gPiArDQo+
ID4gKwlvZmZzZXQgPSByZWFkdyhhZGRyICsgUENJX0NBUEFCSUxJVFlfTElTVCk7DQo+ID4gKwlv
ZmZzZXQgJj0gMHgwMGZmOw0KPiANCj4gR0VOTUFTSyg3LDApIGlzIHByZWZlcnJlZCB0byAweDAw
ZmYuIEFsdGhvdWdoIGEgcHJvcGVybHkgZGVmaW5lZCBtYXNrIHdvdWxkDQo+IGJlIG5pY2UuDQo+
IEFsc28gcGxlYXNlIGNvbnNpZGVyIHVzaW5nIEZJRUxEX0dFVCgpLg0KPiANClRoYW5rIHlvdSBm
b3IgeW91ciBmZWVkYmFjay4NCkkgd2lsbCB1cGRhdGUgdGhlIHBhdGNoIHRvIHVzZSB0aG9zZSBt
YWNyb3MuDQoNCj4gPiArCWNhcF9oZHIgPSByZWFkbChhZGRyICsgb2Zmc2V0KTsNCj4gPiArCXdo
aWxlICgoY2FwX2hkciAmIDB4MDAwMDAwZmYpICE9IFBDSV9DQVBfSURfRVhQKSB7DQo+IA0KPiBT
YW1lIGNvbW1lbnQgYXMgYWJvdmUNCj4gDQo+IA0KPiA+ICsJCW9mZnNldCA9IChjYXBfaGRyID4+
IDgpICYgMHgwMDAwMDBmZjsNCj4gDQo+IEFsc28gaGVyZQ0KPiANCj4gPiArCQlpZiAob2Zmc2V0
ID09IDApIC8vIEVuZCBvZiBjYXBhYmlsaXR5IGxpc3QNCj4gDQo+IFBsZWFzZSB1c2UgLyogKi8g
aW5zdGVhZCBvZiAvLyBmb3IgTGludXgga2VybmVsIGNvZGUNCj4gDQpBbHNvIEkgd2lsbCBmaXgg
aXQuDQoNCj4gPiArCQkJYnJlYWs7DQo+ID4gKwkJY2FwX2hkciA9IHJlYWRsKGFkZHIgKyBvZmZz
ZXQpOw0KPiA+ICsJfQ0KPiA+ICsJaWYgKG9mZnNldCkgew0KPiA+ICsJCXJpLT5yY2RfbG5rY2Fw
ID0gcmVhZGwoYWRkciArIG9mZnNldCArIFBDSV9FWFBfTE5LQ0FQKTsNCj4gPiArCQlyaS0+cmNk
X2xua2N0cmwgPSByZWFkbChhZGRyICsgb2Zmc2V0ICsgUENJX0VYUF9MTktDVEwpOw0KPiA+ICsJ
CXJpLT5yY2RfbG5rc3RhdHVzID0gcmVhZGwoYWRkciArIG9mZnNldCArIFBDSV9FWFBfTE5LU1RB
KTsNCj4gPiArCX0NCj4gPiArDQo+ID4gIAlpb3VubWFwKGFkZHIpOw0KPiA+ICAJcmVsZWFzZV9t
ZW1fcmVnaW9uKHJjcmIsIFNaXzRLKTsNCj4gPg0K

