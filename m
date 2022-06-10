Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF76546329
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jun 2022 12:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346898AbiFJKHa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jun 2022 06:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242942AbiFJKH2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2022 06:07:28 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2025.outbound.protection.outlook.com [40.92.52.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C92BB57B0;
        Fri, 10 Jun 2022 03:07:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+pwQHeh98EhLihgSuF6fzOvKE2l/4L6+dBLvMIidNtSSV3Mzb3aJTkvMNn57WiJRlDLdlmdFudL804Fv9h+PmKlqQN5exvBmj9TUwkYCjy25RR84+ngxb4Hs24vDNUZ7MfVKIutJJ2+/lCEI7eUd2taZIq8DjcQJpgxwlI9fJDeIitKx8AfbLcFPnd9XE2CDeQyK1Y3x3FW8eWiOyDW7hWQkiX9OAMn2cUxxw6CPkUvtZ4w9ofwpiUF3XYzzysU4zFz4vFYUhkAuh6cxPn7hVl9MhT1UhE11+KpGYFj112zMW2jf7drINVExINm13fBDsCBb5dTJYqN/qkmAzq82Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PL3YNUCWTKTHeu9gtkLYN4b9RCEFUIV19pI4PFyL1Gs=;
 b=B22/Lp4f8Eiv+pmfta6KEbQY7Mb25uXeOynRRl5s/hdD0Wo2t8DjxwB0dO3z3q1QA2IjkOl4/tYiMQd4a5hSqTzj9STAIX76C+qlUnc+J5E5ZRzaC3iljd/FshTjI/F3w6k2xabX0MN9Tgu0S6kSMFYnZIk4/IZ0HLpDsvh65QJftVWv/CYMdLplQi+AcfaK3E1djhDZ3aC/kqWqJbc9uSut181vo4sEc36tZr2g9lPk7IMTXrlBncxUr2M7mEkqMPcm3QEJouZCbaIqE6Ixek8uJ4jK4rteAHsob9k5sSP5IApEv5hqpjhjfeO+0GHgyaBtOGSNPiAheyaFzYAHXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PL3YNUCWTKTHeu9gtkLYN4b9RCEFUIV19pI4PFyL1Gs=;
 b=D6nupp9uTLnnuBh5sLW2ncEMB/pHFusJpC/U8qN5dAVTOKcWFO8hkJdI7Aj7D11rsHgDgcBqA9O0ZivaNBHOMMoky1C522exYqZvRZ/uL50ZId4ZrKTrgym9u8/IXX+O8jYi707YMHxaBtQ2yYMAd9JUV4yONNStaSSHGk0fsevlAIsEw1Fyn9cq+hl48ZVcJBol24bBVqSoSWESFSilWCwJE+7ofZQhsVQ9TVZIUIzQ7IWrgalzAkWjyBeZJ3Zir9+SNXMUVKJ71GHZ4zG33BwdSW8WgS3bm+QcoT/tIuriwAHRjyYbOrQ+lI1zWYdl7nxWctvttL+DLlP7qgwirA==
Received: from SG2PR01MB2951.apcprd01.prod.exchangelabs.com
 (2603:1096:4:76::15) by PU1PR01MB2011.apcprd01.prod.exchangelabs.com
 (2603:1096:803:20::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Fri, 10 Jun
 2022 10:07:18 +0000
Received: from SG2PR01MB2951.apcprd01.prod.exchangelabs.com
 ([fe80::a1f7:b32:baa1:3d12]) by SG2PR01MB2951.apcprd01.prod.exchangelabs.com
 ([fe80::a1f7:b32:baa1:3d12%7]) with mapi id 15.20.5332.013; Fri, 10 Jun 2022
 10:07:17 +0000
Date:   Fri, 10 Jun 2022 18:07:11 +0800
Subject: Reply: Re: [PATCH] mm: eliminate ifdef of HAVE_IOREMAP_PROT in .c
 files
Message-ID: <SG2PR01MB29516A1F4944ACA5A2A590369FA69@SG2PR01MB2951.apcprd01.prod.exchangelabs.com>
From:   "wenhu.wang" <wenhu.wang@hotmail.com>
To:     Wang Wenhu <lonehugo@hotmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        Xu Yilun <yilun.xu@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:FPGA DFL DRIVERS" <linux-fpga@vger.kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        "wenhu.wang" <wenhu.wang@hotmail.com>
In-Reply-To: <YqMRtWAH5fIWsLQB@kroah.com>
References: <PN3PR01MB7725BD573E8D63C1CB978AD8D2A69@PN3PR01MB7725.INDPRD01.PROD.OUTLOOK.COM> <PN3PR01MB7725BD573E8D63C1CB978AD8D2A69@PN3PR01MB7725.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: multipart/alternative; boundary="--_com.android.email_473340926606670"
X-TMN:  [MhVPdkHbEoKuLBUNQ6SKHlRw0bmFybWthfNGd/JpG06cdfhFbc7f37O8efPB15eZ]
X-ClientProxiedBy: SGAP274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::23)
 To SG2PR01MB2951.apcprd01.prod.exchangelabs.com (2603:1096:4:76::15)
X-Microsoft-Original-Message-ID: <ga9eito3rj9u98srcifggl41.1654855631847@email.vivo.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ace85a0b-28be-4eee-69b3-08da4ac8ffb0
X-MS-Exchange-SLBlob-MailProps: AsidyrAlbSRuFNKN5HVNBsHxCmV50H2O8+ICLDNpZcxG0XvP8iLMx/hMJfTaX7WZs2Ez6Ha7F22ZHJT6VVCXSrq5y8MptrQR2uWogJnEhlxO/q+hkSItmAGYgAO8V/w8Al+Q7qmDvg88SXGH8u1YqGJzDDe1kk+4mVOsYNibqcPuyOw93kJAT0naDaaE5Urgr3+zA76fR4PxiQti08K3kJYhjJkUEaUtfZTGXCH0ARzcutFIjcTOsYJo0G1BK4Y00xA51/ng/1ZiL6fROLuuH2yhH5lUrwF4ifa8OMENeaG1JGEP7UaDh0dHa8n72B9tiL3Z9H/KbQKQVhkbgkCJdMkY+ftyKeEA3NdDeLWUcyihoxhtTc5326f0Fhh4EDfX6/T66NBxKJwIxDwx5jwT+ieuITV+JKNt4IVDzXQ2uAMNLGgW3bl5u/Oj5nRqovdFixb41hiJPeZgQ2lqXPH/FktyHOIIkI7AaFEeDqgYiZ556ykzWZIPSujrESI0eZogKsYRyb9NcX1pwREvUEGZ79rQ4U12NyyGv5Ar8WEAcMPMRCwC9FJM9m8gm6iYbDSa3jLDqemTIARXAlRyYHn/u1pD1Nwxg88CAtLwoSh45yth23HPtgb1ScLA+5//R2DpRYXAw9FVyY49ecMJQRrowTdMt064n8kLYPPY8q+WGS2JIO2y6wG45soG71JcVmOa0AFvhs0x1d2UpP1I6hZZPbwhCdrVC8t8W0Qk6VYgG67iLUQvXFXX/fHySNO2lBD2L837CADTJAxMOFvoMCoQlJHh6bFou4ZUlEe9nyXgWFJGBHgD1TA2qNIn10PkITMngy6q20sglkMN6MbydwDF1T5xBJDzbXsX
X-MS-TrafficTypeDiagnostic: PU1PR01MB2011:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pA3iGp4a/GqdB6wj9FWAr9wlTLTozzGjk17ro7VK+vyh2Z6u0c7Js3Fb7ITr4KEUzyr92BPZm+ORr8DJMpWlmCklrELAmcKpPghMM/dKbnHndj9//Edju6ezftjzWyozBRgdgbJEAsQX2kV2sIlrxACdGm6b4J5z7fBRkZt6Mj7zCixiJpRX6aYBiJncloL2jLcbZNMR+RwMT8AFSXG0Vz7aCmu64RvXqb4vE3+7iWdGmNT9zhDzKOs9Y8M2aOlIFtMwe9UL4C6/BS03S6iuq7wQ8rvlrXb2QQ/9+d7BSJ7t1mR86e5TT4EgOAOYT1bHuGy2KxLD8TVkq+DPblqERVK6THUfZBhApwXElyzR9HZtgUf42JPKTjU4YKMCcTEq36oml3XJ7tvpCkw6aeEHpaPiW+fTaB6vAU38PNTYShT11in1aQtQymV3JpytioQDYLiv2nwxeN6s3BuSxVMnBmHIAxr9PAU4kzxc+xxY4YwFArRfv1jwm3+oKUwlSM93x7lbOG7jz44kt+GbMlxc4t6mfv15Vh0FBxpX1fjxowMidmMdymRNTh2PynonKFs5PZfFDi4c1VWCxHfjCrx4nCX0+CB/vG53qvZoUH8ABvO+BJl3P3mIuTtdYw1qwCTL
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWJZZ29yUjdGRTkrcGpQOFN6RDd1eXdKell0dkkwSjVjTHNjaXVRY2xwMVpP?=
 =?utf-8?B?YUNZZDh3Vm56b21EZnlXZ1p0eHFtKzlkSzNwd1J6L2h2elZ3VW5ZQmhoYnJj?=
 =?utf-8?B?YThsL3pwU3hpYlFXNmhBa3JOcTQ4V3U5eC81UGpjLzhSbTZSWE9DZjViV2NG?=
 =?utf-8?B?TzEzVkg4U3gxKzZzRkZRNFhGZmpqelNQK3hPTGVyWU4vVjllRFlFcFpKdFcx?=
 =?utf-8?B?YmVmME1FRzNOeFV6ZkNqSVJqOHV0eWFKKy9kaVFySUxWTC9xQTFqbnZHTVVX?=
 =?utf-8?B?TGc1TXBwMWlDeXFrTE1xMGxBbXFUSHZXai9XNDcrSXlib1JpVG9aYi81RUtN?=
 =?utf-8?B?NFFoOGd0ZWw1c2JxMEFGbXd3TUFBeGw4aGtXbnExM21ZNXZTNVJJN2NHWkF5?=
 =?utf-8?B?bkxqZ3pmb01uNXFHTURPNUFzbXZCbUZJZGZ0bFJ5RCt5UE1BNXFzdVRKSTYv?=
 =?utf-8?B?MENIc29xN3A1SkIvb3UxNmY5V25sTFRBZ1V0T0lNS2xKcG5WaUJJdnVNVU02?=
 =?utf-8?B?bkNReERZeGE4RWNHeFZ0MEhQVVlaT0hnZ0FwU0ZVVUhrQnNqSGljazVkMkdo?=
 =?utf-8?B?TTUyR2RTK1hpM0pqeEE1ZUdnMW9XK1RLdFU3NVNTOFFNUVdza1FPeXoxbnpD?=
 =?utf-8?B?NGN5UWhoQitYanNkSmU5OUxRYXg2UmFFK1JEMzNnbDh3RG1iK2hJbTE5Mnl3?=
 =?utf-8?B?NHZOODZPYVhVTllqcjN2aC85bFdBZm1pdDNvKzk4dmUvNitqV1dSR0Y1bXNJ?=
 =?utf-8?B?NmhSd0duL3NGUjk0aXpuVFc3Z29vUDdGbTlWWXpkaXhGMkNpN24xRUFKNDA2?=
 =?utf-8?B?ZDY5NThlQkJ3MmNOeFhkaDFRam5MUHNyNVZSUVZ5dERPQndpb0FOTHJ2TFk4?=
 =?utf-8?B?ei95T3F6NEg5eGZNRGNkdlluWXFxUmIxS1U4QW5IbGhkRS9XV0ZHcHlKb2J1?=
 =?utf-8?B?RHdrNDFYT3NJOEtadkhIejRuQXNSeWZ2empGMFBtNXBKMUdkN2dOTE9leVo2?=
 =?utf-8?B?VGthVUYwWnNoN3AvT0JpWWVITHdxREhpVmxlbTA3T2pBd3dKK0hEN0FqTlFk?=
 =?utf-8?B?alptNWFrVFc0MzBtcW5HMXdYaE12aUgwbzlFV01zcDl3a3dwZWNUcGlVNzRN?=
 =?utf-8?B?MWt6WGNKYUFnRnFNbW9NcHFPSDQzTTNQdzUvdWJaMjdMcDEycjJtQURwTDQ2?=
 =?utf-8?B?ZkRpOSsyMmlKR01YUXE4T1Q1VWIxRXB2dzNFL2FSOWRUTEI3Z3ZQZ2dCUi9H?=
 =?utf-8?B?cFpOSkN6YjhOSE5sSGphK2YrdmpIRzZveEJDbjVRWHN0cFh6ai90QWxSQnFI?=
 =?utf-8?B?RC9QckR2NTArNFBxV1NNT1dXc2hRWVNYT3k0VjloQ0JEdXUyOVJla0wwQjBV?=
 =?utf-8?B?VXRNNkFoL2F6OHFHancvbGs3UXdpV1I2d1VqbDdKMlZ3anlvUjZhaXhMSnZS?=
 =?utf-8?B?Zk9GVG5XTEowM2Z6dlF2STdCTUVOYjlSNTJDTTFFdStnQUx3WHVsRmgrZkFx?=
 =?utf-8?B?MEY5NHlFNUlMVUhaVk54U3c3SExHajlhZ3gyM2Y1bzBCS0huQ3dyRkVTNG5Z?=
 =?utf-8?B?aWEwbVFFRU84OXhtdEVmeDBidklPTmFaNDBmckV1SHNROG0wSURZK1A0RlZT?=
 =?utf-8?B?RzFLOVFjRlFyWXpndG5EanJaVENJMVRIRDRkbzIyd0psU2tici9WRGlDTEtQ?=
 =?utf-8?B?SEZFUlcwaVl4QWpoUXdHREtKS1dhNXRBNnA1WG9OZGxIRGd4N3NZaFhLVGo5?=
 =?utf-8?B?NlM1ZVZhVTRqWVE2NHF3SEdIaG1jK0IrOEYrUmMxZUQwNlp5YlAxbmw3MGRH?=
 =?utf-8?B?QjlWQzZMYkNQTWp6eFc3ZW9yTEJGZjBiL2x5eTdpZFhIY0Z3MmhJd1psTk5C?=
 =?utf-8?B?dFpIT2RURnFBYVRhMG5nQm53YzdRNU9ZNExzaEx1WWNLNjY4YjBVSzhOK0Qx?=
 =?utf-8?B?c2JjaFcvcmpXU3pzS3ZFSDNJMmg1Q2pmMzA5SVd2b1RwMjVYY1gxVWdHOUpi?=
 =?utf-8?Q?b9JQtA/7MCZqfs5PqYNIlRvEnr86tQ=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-d8e84.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ace85a0b-28be-4eee-69b3-08da4ac8ffb0
X-MS-Exchange-CrossTenant-AuthSource: SG2PR01MB2951.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 10:07:17.8136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1PR01MB2011
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

----_com.android.email_473340926606670
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

Cj4gT24gRnJpLCBKdW4gMTAsIDIwMjIgYXQgMDI6MjU6MThBTSAtMDcwMCwgV2FuZyBXZW5odSB3
cm90ZTogCj4gPiBJdCBpcyByZWNvbW1lbmRlZCBpbiB0aGUgIkNvbmRpdGlvbmFsIENvbXBpbGF0
aW9uIiBjaGFwdGVyIG9mIGtlcm5lbCAKPiA+IGNvZGluZy1zdHlsZSBkb2N1bWVudGF0aW9uIHRo
YXQgcHJlcHJvY2Vzc29yIGNvbmRpdGlvbmFscyBzaG91bGQgbm90IAo+ID4gYmUgdXNlZCBpbiAu
YyBmaWxlcyB3aGVyZXZlciBwb3NzaWJsZS4gCj4gPiAKPiA+IEFzIGZvciB0aGUgbWljcm8gQ09O
RklHX0hBVkVfSU9SRU1BUF9QUk9ULCBub3cgaXQncyBhIHByb3BlciBjaGFuY2UgCj4gPiB0byBl
bGltaW5hdGUgaXQgaW4gLmMgZmlsZXMgYXMgd2UgYWRkIGEgbm8tb3AgZnVuY3Rpb24gZGVmaW5h
dGlvbiAKPiA+IGluIHRoZSBoZWFkZXIgZmlsZSBpZiB0aGUgbWljcm8gaXMgbm90IGVuYWJsZWQu
IAo+ID4gCj4gPiBUaGUgbWFpbiB0cmlnZ2VyIGZvciB0aGlzIHBhdGNoIGlzIGFuIFVJTyBkcml2
ZXIgc2VyaWVzIGFuZCBhcyBHcmVnIAo+ID4gY29tbWVudGVkIHdlJ2QgYmV0dGVyIG5vdCB1c2Ug
c3VjaCBwcmVwcm9jZXNzb3IgY29udGlvbmFscy4gCj4gPiBTZWU6IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2xrbWwvWXFIeTF1WHdDTGxKbWZ0ckBrcm9haC5jb20vIAo+ID4gRm9yIHRoZXJlIGlz
IGxpdHRsZSB3b3JrIHRvIGRvIHdpdGggdGhlIFVJTyBkcml2ZXIsIEkgdHJ5IHRvIHB1c2ggCj4g
PiB0aGlzIGNvbW1pdCBpbmRlcGVuZGVudGx5LiAKPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogV2Fu
ZyBXZW5odSA8bG9uZWh1Z29AaG90bWFpbC5jb20+IAo+ID4gLS0tIAo+ID7CoCBkcml2ZXJzL2No
YXIvbWVtLmPCoMKgwqDCoMKgwqDCoMKgwqAgfCAyIC0tIAo+ID7CoCBkcml2ZXJzL2ZwZ2EvZGZs
LWFmdS1tYWluLmMgfCAyIC0tIAo+ID7CoCBkcml2ZXJzL3BjaS9tbWFwLmPCoMKgwqDCoMKgwqDC
oMKgwqAgfCAyIC0tIAo+ID7CoCBkcml2ZXJzL3Vpby91aW8uY8KgwqDCoMKgwqDCoMKgwqDCoMKg
IHwgMiAtLSAKPiA+wqAgaW5jbHVkZS9saW51eC9tbS5owqDCoMKgwqDCoMKgwqDCoMKgIHwgOCAr
KysrKysrKyAKPiA+wqAgbW0vbWVtb3J5LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB8IDQgLS0tLSAKPiA+wqAgNiBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDEyIGRl
bGV0aW9ucygtKSAKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2hhci9tZW0uYyBiL2Ry
aXZlcnMvY2hhci9tZW0uYyAKPiA+IGluZGV4IDg0Y2E5OGVkMWRhZC4uNDAxODZhNDQxZTM4IDEw
MDY0NCAKPiA+IC0tLSBhL2RyaXZlcnMvY2hhci9tZW0uYyAKPiA+ICsrKyBiL2RyaXZlcnMvY2hh
ci9tZW0uYyAKPiA+IEBAIC0zNTQsOSArMzU0LDcgQEAgc3RhdGljIGlubGluZSBpbnQgcHJpdmF0
ZV9tYXBwaW5nX29rKHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hKSAKPiA+wqAgI2VuZGlmIAo+
ID7CoCAKPiA+wqAgc3RhdGljIGNvbnN0IHN0cnVjdCB2bV9vcGVyYXRpb25zX3N0cnVjdCBtbWFw
X21lbV9vcHMgPSB7IAo+ID4gLSNpZmRlZiBDT05GSUdfSEFWRV9JT1JFTUFQX1BST1QgCj4gPsKg
IC5hY2Nlc3MgPSBnZW5lcmljX2FjY2Vzc19waHlzIAo+ID4gLSNlbmRpZiAKPiA+wqAgfTsgCj4g
PsKgIAo+ID7CoCBzdGF0aWMgaW50IG1tYXBfbWVtKHN0cnVjdCBmaWxlICpmaWxlLCBzdHJ1Y3Qg
dm1fYXJlYV9zdHJ1Y3QgKnZtYSkgCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9mcGdhL2RmbC1h
ZnUtbWFpbi5jIGIvZHJpdmVycy9mcGdhL2RmbC1hZnUtbWFpbi5jIAo+ID4gaW5kZXggN2Y2MjFl
OTZkM2I4Li44MzNlMTQ4MDZjN2EgMTAwNjQ0IAo+ID4gLS0tIGEvZHJpdmVycy9mcGdhL2RmbC1h
ZnUtbWFpbi5jIAo+ID4gKysrIGIvZHJpdmVycy9mcGdhL2RmbC1hZnUtbWFpbi5jIAo+ID4gQEAg
LTc5Nyw5ICs3OTcsNyBAQCBzdGF0aWMgbG9uZyBhZnVfaW9jdGwoc3RydWN0IGZpbGUgKmZpbHAs
IHVuc2lnbmVkIGludCBjbWQsIHVuc2lnbmVkIGxvbmcgYXJnKSAKPiA+wqAgfSAKPiA+wqAgCj4g
PsKgIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgdm1fb3BlcmF0aW9uc19zdHJ1Y3QgYWZ1X3ZtYV9vcHMg
PSB7IAo+ID4gLSNpZmRlZiBDT05GSUdfSEFWRV9JT1JFTUFQX1BST1QgCj4gPsKgIC5hY2Nlc3Mg
PSBnZW5lcmljX2FjY2Vzc19waHlzLCAKPiA+IC0jZW5kaWYgCj4gPsKgIH07IAo+ID7CoCAKPiA+
wqAgc3RhdGljIGludCBhZnVfbW1hcChzdHJ1Y3QgZmlsZSAqZmlscCwgc3RydWN0IHZtX2FyZWFf
c3RydWN0ICp2bWEpIAo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL21tYXAuYyBiL2RyaXZl
cnMvcGNpL21tYXAuYyAKPiA+IGluZGV4IGI4YzkwMTE5ODdmNC4uMWRjZmFiZjgwNDUzIDEwMDY0
NCAKPiA+IC0tLSBhL2RyaXZlcnMvcGNpL21tYXAuYyAKPiA+ICsrKyBiL2RyaXZlcnMvcGNpL21t
YXAuYyAKPiA+IEBAIC0zNSw5ICszNSw3IEBAIGludCBwY2lfbW1hcF9wYWdlX3JhbmdlKHN0cnVj
dCBwY2lfZGV2ICpwZGV2LCBpbnQgYmFyLCAKPiA+wqAgI2VuZGlmIAo+ID7CoCAKPiA+wqAgc3Rh
dGljIGNvbnN0IHN0cnVjdCB2bV9vcGVyYXRpb25zX3N0cnVjdCBwY2lfcGh5c192bV9vcHMgPSB7
IAo+ID4gLSNpZmRlZiBDT05GSUdfSEFWRV9JT1JFTUFQX1BST1QgCj4gPsKgIC5hY2Nlc3MgPSBn
ZW5lcmljX2FjY2Vzc19waHlzLCAKPiA+IC0jZW5kaWYgCj4gPsKgIH07IAo+ID7CoCAKPiA+wqAg
aW50IHBjaV9tbWFwX3Jlc291cmNlX3JhbmdlKHN0cnVjdCBwY2lfZGV2ICpwZGV2LCBpbnQgYmFy
LCAKPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Vpby91aW8uYyBiL2RyaXZlcnMvdWlvL3Vpby5j
IAo+ID4gaW5kZXggNDNhZmJiN2M1YWI5Li5jOTIwNWExMjEwMDcgMTAwNjQ0IAo+ID4gLS0tIGEv
ZHJpdmVycy91aW8vdWlvLmMgCj4gPiArKysgYi9kcml2ZXJzL3Vpby91aW8uYyAKPiA+IEBAIC03
MTksOSArNzE5LDcgQEAgc3RhdGljIGludCB1aW9fbW1hcF9sb2dpY2FsKHN0cnVjdCB2bV9hcmVh
X3N0cnVjdCAqdm1hKSAKPiA+wqAgfSAKPiA+wqAgCj4gPsKgIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
dm1fb3BlcmF0aW9uc19zdHJ1Y3QgdWlvX3BoeXNpY2FsX3ZtX29wcyA9IHsgCj4gPiAtI2lmZGVm
IENPTkZJR19IQVZFX0lPUkVNQVBfUFJPVCAKPiA+wqAgLmFjY2VzcyA9IGdlbmVyaWNfYWNjZXNz
X3BoeXMsIAo+ID4gLSNlbmRpZiAKPiA+wqAgfTsgCj4gPsKgIAo+ID7CoCBzdGF0aWMgaW50IHVp
b19tbWFwX3BoeXNpY2FsKHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hKSAKPiA+IGRpZmYgLS1n
aXQgYS9pbmNsdWRlL2xpbnV4L21tLmggYi9pbmNsdWRlL2xpbnV4L21tLmggCj4gPiBpbmRleCBi
YzhmMzI2YmUwY2UuLjY2ZDBjZmY2MDU0ZSAxMDA2NDQgCj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4
L21tLmggCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L21tLmggCj4gPiBAQCAtMTg1Nyw4ICsxODU3
LDE2IEBAIGludCBmb2xsb3dfcGZuKHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hLCB1bnNpZ25l
ZCBsb25nIGFkZHJlc3MsIAo+ID7CoCB1bnNpZ25lZCBsb25nICpwZm4pOyAKPiA+wqAgaW50IGZv
bGxvd19waHlzKHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hLCB1bnNpZ25lZCBsb25nIGFkZHJl
c3MsIAo+ID7CoCB1bnNpZ25lZCBpbnQgZmxhZ3MsIHVuc2lnbmVkIGxvbmcgKnByb3QsIHJlc291
cmNlX3NpemVfdCAqcGh5cyk7IAo+ID4gKyNpZmRlZiBDT05GSUdfSEFWRV9JT1JFTUFQX1BST1Qg
Cj4gPsKgIGludCBnZW5lcmljX2FjY2Vzc19waHlzKHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1h
LCB1bnNpZ25lZCBsb25nIGFkZHIsIAo+ID7CoCB2b2lkICpidWYsIGludCBsZW4sIGludCB3cml0
ZSk7IAo+ID4gKyNlbHNlIAo+ID4gK2ludCBnZW5lcmljX2FjY2Vzc19waHlzKHN0cnVjdCB2bV9h
cmVhX3N0cnVjdCAqdm1hLCB1bnNpZ25lZCBsb25nIGFkZHIsIAo+ID4gKyB2b2lkICpidWYsIGlu
dCBsZW4sIGludCB3cml0ZSkgCj4KPiBUaGlzIG5lZWRzIHRvIGJlIGFuIGlubGluZSBmdW5jdGlv
biwgcmlnaHQ/IAo+Cj4gRGlkIHlvdSB0ZXN0IGJ1aWxkIHRoaXM/IAo+Cj4gdGhhbmtzLCAKPgo+
IGdyZWcgay1oIApTdXJlbHkgaXQgc2hvdWxkIGhhdmUgYmVlbiBzdGF0aWMgaW5saW5lIG9yZWxz
ZSB1bmRlZmluZSBlcnJvciBoYXBwZW5zLgpJIHRlc3RlZCB3aXRoIHRoZSBtaWNybyBlbmFibGVk
IG9uIHBwYywgYW5kIGRpc2FibGVkIG9uIGFybTY0LApidXQgSSBtaXNzZWQgdXAgY29uZmlndXJh
dGlvbnMgb24gYXJtIHRlc3RpbmcgY29kZSB0aGF0IGl0J3Mgc3RpbGwgb24uCkkgd2lsbCByZS1j
b25maXJtIGl0IGFuZCB1cGRhdGUgdGhlIHBhdGNoIGxhdGVyLgoKdGhhbmtzLApXZW5odQ==

----_com.android.email_473340926606670--
