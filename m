Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18D0C40F638
	for <lists+linux-pci@lfdr.de>; Fri, 17 Sep 2021 12:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241741AbhIQKtc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Sep 2021 06:49:32 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:29784 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241849AbhIQKtc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Sep 2021 06:49:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1631875689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jXZiYU8mKeQlBechJ1DkPrS64flo7XmAmn4tzLrzntA=;
        b=XpYcTTHXhkhmQOzrrSIglMm8Psb5R1+L5s2vC7NH8Mb6aS5zuVtDjl66GvYKd8Mw8Xquvo
        bFtuBgQdkzyTQ0/A2hGUou+WgVDc6g601BIm+KQ+tI/pgjUTOcXfKolqMJBW0detT1Cq0L
        0Zl332wserL0y/jXwQ0Qzie/KmyxuDc=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2056.outbound.protection.outlook.com [104.47.14.56]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-26-yXw_6uaLN6SmmYHNTNyg4Q-1; Fri, 17 Sep 2021 12:48:08 +0200
X-MC-Unique: yXw_6uaLN6SmmYHNTNyg4Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=adtmQkJ1ULl8weYlXLfqUczdzyaPdyGdqyc3AA6q8JQynzvHLdATv0VrQCDvvdSE/b4++5KCtMwrPApM5odmvu9iGGOXKEoiWMunbhAMqZZVXZov2anky5GgFgYPrswuiH8/ON/VQUvWzh6QvPYzit41GScDYvql2IZ+wf8ZhwR/5PLVh+u35wwCWJwxZU8JXyr/mN4tSsRHhobOsaja+a9g2d8RGohew2O8WqabehqDkZ9aimQVsV/Nvgfcz5XmhtKjqGQJ0xmL7QkEhIDJJsrwhkHgD8Ob+6CGMXEoJUoshIJIfrLiBNKZg+zLYGQYQ/trN0ZD00mRjs7qXjOOXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=jXZiYU8mKeQlBechJ1DkPrS64flo7XmAmn4tzLrzntA=;
 b=j/nqEUCa7GJUd+0T1JKPTVMyal9G/iXU+pugQMt96dxm0SoemHhwFG5AGbnd/M5s5DKyee3+hD7YkFg2G06bC55E2q5awNYg+tz2fcMbDnXhzUH0BjB9D+4MjsVrNyGyld6Du/7SwMcTgbJBLa9D36X+iNQiMyDbtuU6WRlqS5PoENKS7NWMTyXJmqkXqhAmBrMI2iMCj7nU4hX7qmXcFVZFigXE1zD/Ppot0oJkVGy2ZwrBpcf+qTlLlF90cLni59PfnDsff8P1cpKmREtce8m3YLfP5NcLo+8NpUQ8Uvg6BKYxwrEdQn+Pb2b42oSyp3Yip0RTiouLk8DeHfv+ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB5600.eurprd04.prod.outlook.com (2603:10a6:803:e7::16)
 by VE1PR04MB6672.eurprd04.prod.outlook.com (2603:10a6:803:127::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 10:48:06 +0000
Received: from VI1PR04MB5600.eurprd04.prod.outlook.com
 ([fe80::4d37:ec64:4e90:b16b]) by VI1PR04MB5600.eurprd04.prod.outlook.com
 ([fe80::4d37:ec64:4e90:b16b%7]) with mapi id 15.20.4523.016; Fri, 17 Sep 2021
 10:48:06 +0000
Subject: [PATCH v2 2/4] PCI: only build xen-pcifront in PV-enabled
 environments
From:   Jan Beulich <jbeulich@suse.com>
To:     "bhelgaas@google.com" <bhelgaas@google.com>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "hch@lst.de" <hch@lst.de>, Konrad Wilk <konrad.wilk@oracle.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <164e58ff-2edd-2c99-ac3d-e18eb06ff731@suse.com>
Message-ID: <3a7f6c9b-215d-b593-8056-b5fe605dafd7@suse.com>
Date:   Fri, 17 Sep 2021 12:48:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <164e58ff-2edd-2c99-ac3d-e18eb06ff731@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P251CA0018.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::23) To VI1PR04MB5600.eurprd04.prod.outlook.com
 (2603:10a6:803:e7::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.156.60.236] (37.24.206.209) by AM8P251CA0018.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:21b::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 10:48:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04d4e28e-4bc9-4a09-c08e-08d979c8a182
X-MS-TrafficTypeDiagnostic: VE1PR04MB6672:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB66723E1C4BD9E731501F775AB3DD9@VE1PR04MB6672.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vHhBhsWw8iSpZCCjgEQ2YpqZ/HxIdaG8FMKZH1wTEz2kM8WSZLAr2HmIU6FzFA004Vw2/xNXc8dN5vvGj3ioWcjaTiqqqxHkKki7Tq3dpdXAhn9hDa99z96dCBHW44ppdd8Eo6a9Wu06Q0Vaphb+FfNtKAluA3W+s+2TPata/OEfZO8yOHtCWidwuDNRS+02taRvCcVdGYHW1VtXq3ntXyIqYTxTlAzyZ6xmn9ZuYQXLlrZTsGStqMJm8kIyTHN39l2j1zukvZDMlqIHiD+2FjPqmJ/T4SIV2h4mfpH3SGXUgjLw2hqAXK0LQ2DDPsnS/mEofLF65drQxVYU0IkA57IY96NUX1Fa87x8fhhUgcHJGQfE6JbhBLCz0h2DsMoqoKTA0K/U1ndj7SkezAs39nLjJzqSpSYtJs7WsISHQgNZknDDlSyl6s1vooA96W4Ht89b7dj7WbHQnNvdt77wckuTfA40zm95lxB/LQ0PkMwPVXbZY4E4TAOBC/n7jpNa4+uLzlzZRK8f8PiX2F1CXW/bgbC93IlHAauhkbr8CcDuB9W96ZOvXxoPUop8bCDCHUnj4JKSpDxyE4lXaL+cDd2pvEmGkCnDzW5+JVPyOXzW9qRTqP4ovD6uD3h62SsQzWKf8Bt4XaoGdhiEOc1fESeGj9TBO0oH+NEj5bhnyo5UcbpLlMqRN7BH9qtHN1WCVo2hdOFGnKr9NtArMFr7+nZZ2VFSevPub6CDxB9yYLE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5600.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(136003)(346002)(376002)(366004)(478600001)(2906002)(956004)(26005)(8676002)(38100700002)(86362001)(31686004)(5660300002)(6916009)(31696002)(186003)(66946007)(54906003)(4744005)(2616005)(66476007)(16576012)(66556008)(316002)(6486002)(8936002)(36756003)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzdKbmVlMUFDYmtaRDRyQWVYcG5WOVo2R0JaeDZiRXVZUzU3bUk1V2VBU2JI?=
 =?utf-8?B?R2lpK2NpRkh0L3k2dno4V0wwbU1TY2F4RnQzWG44eitraWxXWjloN0VCTkF5?=
 =?utf-8?B?QklHL21vSXRPTENsT01Qb2U3YlFTc1l4ZmIwcjgwTkRCclhLbzgzRmlGVXRJ?=
 =?utf-8?B?Sksxc2c2SFp5NVQrQ3ZIaWVCenV2Myt3dEROWk5hR3lnT1FWTldWN1g3TXpJ?=
 =?utf-8?B?YmNpRENaa3BWQklvSzJYZXZTUWdkNlZCWi9tVUNWNXUxdFRUU0hsYlM5akdl?=
 =?utf-8?B?SERDQ2w1NFZZMTRucEJ5ek5kdndRenAwU3lHbzN0ZXZDQStzcVgrQ29nQm15?=
 =?utf-8?B?a1Z6RnY5WjlIMFZOVXBaNUNYcUE2a2tEdnpJd21HbXhuMWlWeHBnOFZGY1Ax?=
 =?utf-8?B?c3JRUC8yNFBsQW9nVU1TN2hHNlRwK2JSZUVEME5XWmJjT1MzdWc0V3NhTVZw?=
 =?utf-8?B?Njc0anl2RDRkb0xhS3VPeXRVSVpadFJyR2ZtTWE3b3BDeE1wZzd2OGVMelBh?=
 =?utf-8?B?cklSbEpBWSsrdWhpR1hCZ0Q2UGd4ZVk3TnNkRTZ2WFQzaG1EWGRPUEpRZTRq?=
 =?utf-8?B?ZE9GWFVEdEQxQjRkSG0rVTl5NnM2TmdGbSt1SGVNTjVaNmJXaVQzbjhSZVcv?=
 =?utf-8?B?K3lMcVJ6OEN0eGtBOGFhOUJaZDFZZmJtdHp5MTJKaTBTc2xYREpmbjJ5Q082?=
 =?utf-8?B?MWlYcjA0UFBFb2l2emlmdWxNQm9oNE13U1I4NWxLZy9qenpQWTd0bkVocHdp?=
 =?utf-8?B?Q2RvamtoOWVwWkFXVzVRWVNjcUYzNFM0c0JNTFFuWVc3b1QwRHlxcCtaa0Ji?=
 =?utf-8?B?UnFiQ3NRNUpReldFTC9mcUNHdUhrRHhFUXpEbXJ5VFpBZG1JUjR5VmgzcDBn?=
 =?utf-8?B?azZIN0pmakUwQkhrbXFSbTdsVkZKdTA0bjdNM2lSVnVseUVXNEkxM0xaUDR0?=
 =?utf-8?B?SUkyNkVaZWZ0TUxCMTU5aCtqV0NieXFiaU5LMEFGUDBlU00wU3lQRnYyVFdQ?=
 =?utf-8?B?YjkzSyt6ck1GZVdrTWhNMWIzeFNtWXpFTDNGc2xOT252b2NZK2xBeTg3MG5j?=
 =?utf-8?B?VmFwMzNRNThpdGQ3SndncWI4WWxVbm5iZU5PSXJURDVLUXdzS1JiM2JVd0Qr?=
 =?utf-8?B?Y0g2Nkwrc1AwUjdDOVdGbjR5RTJCSWpRcmU2UEJLSnBWaU04aXo0UEVCaWdM?=
 =?utf-8?B?OVBSay9KKzlKK01jT1F1TXFtRk5wU1c3VWFXU3lQSjZLcU5vN08rNU5ta2xr?=
 =?utf-8?B?bytnTHkrWFkxOWdUOW43VDJxM21iczBPb1JlRTl4amQ3MWY2eExheVdHQkln?=
 =?utf-8?B?cmZJQVZBWE84L2hwMXk0Y1ZEcnBHVlJURUJYNjk5VjJabzhCaDJhN0ZXYXNt?=
 =?utf-8?B?WmhUaXJUWExDZ3NIM3JOK0NxVDBpWEQ1RXFYcmM3WmN4ZnkzRWZYeHNSb3VB?=
 =?utf-8?B?SEEzWDltQmtxd3dqR0RsaEdOb0hzTVVyZEZBQWhyM0F4VnFzUlQzTWJJMUln?=
 =?utf-8?B?d2FQbHI4ZEJ0dlFnVGd3YUlDN09qdlM5OTBYOXlJSzJ0a0MxamZXS21teEw3?=
 =?utf-8?B?VFhCTFZnL3pOZW9uK0pqbzB3akl5T29vUGErUkExeEtweUpvMk45N1RXRTJk?=
 =?utf-8?B?Nkw2NXRXTVd3RE4rRk5CVFdhZzY0cUEvVlhCMFp3eEpwNk9YQTFySFdlMXhB?=
 =?utf-8?B?c1g1aVBJSUVGUCtqUVluNDhnS3pCUG1WckNSTjhMZjNzMXU4elp3c05uUC9h?=
 =?utf-8?Q?y3xYC90l34sRKq92sh6lihAQYpTsyzjakHfQaFa?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04d4e28e-4bc9-4a09-c08e-08d979c8a182
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5600.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 10:48:06.0546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vOpc827aY4Y5uJnuMYKPwLaLMXRTrj1B2ZCaA9k5HR/UraVJh/wDUz8abVGpCg0ur5bn94OaTahuHMeNuhFB6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6672
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The driver's module init function, pcifront_init(), invokes
xen_pv_domain() first thing. That construct produces constant "false"
when !CONFIG_XEN_PV. Hence there's no point building the driver in
non-PV configurations.

Drop the (now implicit and generally wrong) X86 dependency: At present,
XEN_PV con only be set when X86 is also enabled. In general an
architecture supporting Xen PV (and PCI) would want to have this driver
built.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
v2: Title and description redone.

--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -110,7 +110,7 @@ config PCI_PF_STUB
 
 config XEN_PCIDEV_FRONTEND
 	tristate "Xen PCI Frontend"
-	depends on X86 && XEN
+	depends on XEN_PV
 	select PCI_XEN
 	select XEN_XENBUS_FRONTEND
 	default y

