Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84AC7B26F4
	for <lists+linux-pci@lfdr.de>; Thu, 28 Sep 2023 23:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjI1VCR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Sep 2023 17:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbjI1VCR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Sep 2023 17:02:17 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2128.outbound.protection.outlook.com [40.107.243.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF4919D;
        Thu, 28 Sep 2023 14:02:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEimIxFeJdHaT1Y2FbKxAvW3Jq5jiqDxlr/aQ2V9JfVSvc+IiCCA/n/boZOKGOsoE58l2bSb0cSkQFVNSiuDJ05TvX+sD/NbSNqTl+8PI0qYz/OZBlj6Q8QLF3uwZo5mri1SqBL1VBMcNX73ZZZLo+UFubTuDltOkvB8Nl3KJsPgaO3Q9eYCWmh2BQ84n3ImTCis0cXh7mjWU7X3O03wnSDswhXVVX1/prb+DEtBfFCY7YRCT3fp+6A79VJCQCjNrqhHZhL87QnCOkwGQw+lsixUwdso86CG3qoGTuw6yD7JeA2cWSGUC6hnuzzmdBWPaonKpDctv8WqYVtnP4+h+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=owo6vy0GiHGGOc3ucntzZxc4B/b1DBBZP1oZ6Szw5zc=;
 b=S3zcPNfJN0ezuBMcVql5ZkUlsc4aWVo2N+RpSfh/iOEm/I2iRjl8pL6A5SD3ezlcwLRmu5R1+pjh1/vD2s7yAI/qyPpcQhOA2j9p6FE1/jyaJWh9hAHlD31hgXB60xOl0jolrC5DjqxqYtClevRpU5cLQw9DQpSAbtq0xKQowGTX5o3mUpto1cD5erOqRHXPs9jF3uHNJpMo2LKWiQsbw9HldQsZ3bFIN1CG6bTaIo5K7beE3mr4YS5qKrezOcUtg5qKr5Cik4kHcHzJe3h8EDEFe8Qx8LMMoAukACMamAvIl60qxoP35puhuiwIqk0nFIf1CHA1jqZge5JFy2w4Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owo6vy0GiHGGOc3ucntzZxc4B/b1DBBZP1oZ6Szw5zc=;
 b=k+z8vRDrQFRwmU8UP3ZbmA/ikYec32Z+y+N2QcJnWf7Huz2D8kn2ijDDphqSocVr0UHooYMuoOgCecWCIefyY//d7HlQ0LMPXpSCAXzAfRqBGRHMk0G+srkEl2Q+XK9Nb59jOLH1EeD/a6vdBimy7QmtFOp0s6sSGUpic0Su0tQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MWHPR0101MB2893.prod.exchangelabs.com (2603:10b6:301:33::25) by
 BN0PR01MB7215.prod.exchangelabs.com (2603:10b6:408:15a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.28; Thu, 28 Sep 2023 21:02:10 +0000
Received: from MWHPR0101MB2893.prod.exchangelabs.com
 ([fe80::ac16:89d:a480:ed6e]) by MWHPR0101MB2893.prod.exchangelabs.com
 ([fe80::ac16:89d:a480:ed6e%4]) with mapi id 15.20.6813.017; Thu, 28 Sep 2023
 21:02:10 +0000
From:   D Scott Phillips <scott@os.amperecomputing.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
        Darren Hart <darren@os.amperecomputing.com>,
        patches@amperecomputing.com
Subject: Re: [PATCH] PCI: hotplug: Add extension driver for Ampere Altra
 hotplug LED control
In-Reply-To: <20230928154720.GA462358@bhelgaas>
References: <20230928154720.GA462358@bhelgaas>
Date:   Thu, 28 Sep 2023 14:02:07 -0700
Message-ID: <86y1gqj9kg.fsf@scott-ph-mail.amperecomputing.com>
Content-Type: text/plain
X-ClientProxiedBy: CH0PR08CA0003.namprd08.prod.outlook.com
 (2603:10b6:610:33::8) To MWHPR0101MB2893.prod.exchangelabs.com
 (2603:10b6:301:33::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR0101MB2893:EE_|BN0PR01MB7215:EE_
X-MS-Office365-Filtering-Correlation-Id: 32043c55-b1bf-4d4d-69bd-08dbc0662dff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UOs+h4NQ6NZzPT3zV3o79NdrYQ9arzmZ/+//DfJGFYuWN6dIwNukk42Nl7usb+lE7XeuTZiDZNtYbpYVe6RKf84HV4lXKrq0ZCUB9Ep13guxga/yM1PWwWtmvY5uFY+xlcNoW7uchU+wMewyJ60d6A5NR0P4Tyi7IlaoX7FAD+6xTq0IZRw8BWHtmVI76XxwryjcgNxXyerbk5ovW4mqWLUZDLyY+X88J2T5wsP9si+v/Jd6dIoncUNZk6cPAf5BY+nIkGwjY1kbLD59hNPb2a8k7TEFvf3YsvJzCKfNRZQE0nfwf1Pp0/m5OcjPaVsifqzsJueG8MRpgvwON4pbS54QvJOuLBQEnIJBPlX/d2TWXix8qeVxJrxjR29wJ1lIOPJfOv4E5pmxaGQqEXPqHx+uze9cdUBtP5B/UTl9v4cfqIh4YcMTlb4J6W92a1+l0WU+hi0TkhciLVL8A4C067viF6sNz7ZJ5Nc5K72JUEv9T/TwvTNNr/h3Bjq1fWYElQZqEKuwl94qCJLdiFBbr/KUObr8gLFEnN37NHGZX88CL7IJQSQaQUOqkYpOT1doLNfSpv7NG5rq52tlTB3dzqftaNxaS8YZZQ8CUY5Bah6/l5ot8L8LiJ0KGaSgZ5NK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR0101MB2893.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39850400004)(396003)(366004)(346002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(107886003)(26005)(6506007)(6486002)(52116002)(6512007)(9686003)(38350700002)(38100700002)(86362001)(4326008)(41300700001)(8676002)(6916009)(83380400001)(8936002)(316002)(66946007)(54906003)(66476007)(66556008)(5660300002)(2906002)(478600001)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IlLnT7lCnt3ASz9nTHLwOekEmisBCirgn8D8NiV3a9WVKYq0BAn6sdFSN1/U?=
 =?us-ascii?Q?kZBSbBdacoQQeuOQS6+Xd3WDK/sqE3USLpnNjfsS96z6VgXd6W1/tQpDzVKA?=
 =?us-ascii?Q?yUbjPuZIYg5htbqj239FLt8Fqp7MDXEUmb45SMtuBYRVczurOjDdxH6cRfpt?=
 =?us-ascii?Q?Os3073bPq5wVGmrsV6N8FfioacWtC9Hr6xTMUtZMrBP0nD/ilRci4QEzf00h?=
 =?us-ascii?Q?KB0Cd8yEh+QhgNCt6SXRwWtJNay5YWuWYyrFZ+rat4tVBMpcEUEz9DQkMLSH?=
 =?us-ascii?Q?rD9CDFXMCnVkstc2U/RwvZbX4K5KmqYwlxGqpDx2Uh7h5YSdW6e56k5HIycK?=
 =?us-ascii?Q?YQdp4CvlzdDWK7yIRKqOZszhV72wROPa5CBsq9Tg+9aAk1bLGIB9ZXOghER5?=
 =?us-ascii?Q?Lx6FanoNiQUXFds/W/ZN6huFAI6NclPc9kZ7PToQkngYDfaWE9K+eDkq++wr?=
 =?us-ascii?Q?laf2ZdVjsW1OaSwrAyyaLikvM/H71/i3e7HA+azr95RgW++s7DOoOai8qOkj?=
 =?us-ascii?Q?V+yRBDzs8fFasMtzhaJhN9G4dI6Mh2qhdLAlEhZKnhtx+FTRDo1LUkHip2Gh?=
 =?us-ascii?Q?W4i96qDwIsp9U3jlkonJbZSYIq8WbgW+qv+6c8seywnrJMgSLZHdJwP9su8l?=
 =?us-ascii?Q?cNYRmzAN1eMyUin3Hry5XE8fTtAZB1N1wY3WoF5QfRPJCEUe2A0Jl4CYN9v+?=
 =?us-ascii?Q?z0vaw+X0iAwOWMNEZ8OFwlmQD1ls/ex8siOycLiKU/Uulx7QQuV/TL1R2LfF?=
 =?us-ascii?Q?9BAHr+ul8RaJbqers6pT8R2JeB5Acuk/wXUb4q3rPIt3i+vXZjbcpxYsv9KM?=
 =?us-ascii?Q?Yzl5wYebvJt0SsMST8Y3Pn5DzFbqeWDuJnhVVKvIAPtZ6APwcyTXCamskvdU?=
 =?us-ascii?Q?gUGtgrEdsk82lihYOyOt9c8SXegZzlBUcQ/YuznigiUEoV4sLXGTtwhypBHL?=
 =?us-ascii?Q?aoxOYriznOrSWCYIq5Wow21bJLxiCOIXQAP/mINIsn3VcRe157VHn1BhNjTI?=
 =?us-ascii?Q?LgG5fWTiv2vMBFSjljt6HqWlB/dvHSJNzqs7G0wJHRQsRcERLCMot31Nxyp2?=
 =?us-ascii?Q?HYIOcb4nLMxY4vijgU/6VCm8BJTJRbjkyT7O1GRI3khBneO3EUf9py+g0PvW?=
 =?us-ascii?Q?q7g6/DW2wXWGT7z0eVAYWiE5lfl7X7AUZSNuanm2blnJY5rZqZiEZK7kBgQ4?=
 =?us-ascii?Q?XgCkSnKdauqhyQ4Uq/nIUWH0YxqdREEOQl/QmXx3qyZMZue18jHUlevi6msA?=
 =?us-ascii?Q?JqKJWE5/SI0hRoqXFsrBoGCtrW7Ps2OzehihxmLZDK+kSYvFgOWy9AMlIIlS?=
 =?us-ascii?Q?Z7M8o4iBe+lhMtTkgWwYuhqQnXMwmKkb/dRifIB8EInsDF54z+/VA8G4osTd?=
 =?us-ascii?Q?ML1z+Dvet4b8w+fIkiPkFf65SDEEdyI5+Es4VjHX7MHGeyEOEvfn0/uYdeVk?=
 =?us-ascii?Q?bakY4bXOwIMhi0I6s44J3DO2PoS7DlS7JkHlm3GwDzKrqht5n1QkBd+PWRQ6?=
 =?us-ascii?Q?ji9yFOHYxyqPs3KSSdYXKMcRdfO31H42je7QZFMHFAEJ+XXy8SX0KJLHjWPS?=
 =?us-ascii?Q?o4OtKBXKYlpTzAaI2JLqoSU/9vn7IN/Q0kTjQGfcka0dysfHgGdcvSCm1fS7?=
 =?us-ascii?Q?6X/EsqZfmmdqTNfxb0Sw43k=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32043c55-b1bf-4d4d-69bd-08dbc0662dff
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0101MB2893.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 21:02:10.2790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QVJ35niUbBoF7TxlXq94Wb5B2AFvTX6DQKM08lL5YWYowQ6yHPSOHh+GI+UM3CClyhEpRLJG1CFvzf4Z/qx6fv0MY8KcbSE6UbLyLy3Tf16ffaNlyg66Ymb9Abav8py1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR01MB7215
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn Helgaas <helgaas@kernel.org> writes:

> On Wed, Sep 27, 2023 at 01:23:47PM -0700, D Scott Phillips wrote:
>> On Ampere Altra, PCIe hotplug is handled through ACPI. A side interface is
>> also present to request system firmware control of attention LEDs. Add an
>> ACPI PCI Hotplug companion driver to support attention LED control.
>> 
>> Signed-off-by: D Scott Phillips <scott@os.amperecomputing.com>
>> ---
>>  drivers/pci/hotplug/Kconfig                |  13 ++
>>  drivers/pci/hotplug/Makefile               |   3 +-
>>  drivers/pci/hotplug/acpiphp_ampere_altra.c | 141 +++++++++++++++++++++
>>  3 files changed, 156 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/pci/hotplug/acpiphp_ampere_altra.c
>> 
>> diff --git a/drivers/pci/hotplug/Kconfig b/drivers/pci/hotplug/Kconfig
>> index 48113b210cf93..9fde600a9ad3e 100644
>> --- a/drivers/pci/hotplug/Kconfig
>> +++ b/drivers/pci/hotplug/Kconfig
>> @@ -61,6 +61,19 @@ config HOTPLUG_PCI_ACPI
>>  
>>  	  When in doubt, say N.
>>  
>> +config HOTPLUG_PCI_ACPI_AMPERE_ALTRA
>> +	tristate "ACPI PCI Hotplug driver Ampere Altra extensions"
>> +	depends on HOTPLUG_PCI_ACPI
>> +	depends on HAVE_ARM_SMCCC_DISCOVERY
>> +	depends on m
>
> Why is this restricted to being a module?  It's not unprecedented, but
> unless this only works as a module for some reason, I would leave that
> choice up to the user.

I did that because acpiphp_register_attention() wouldn't register the
handler unless it was built as a module. Maybe better would be this
change first:

--- a/drivers/pci/hotplug/acpiphp_core.c
+++ b/drivers/pci/hotplug/acpiphp_core.c
@@ -78,8 +78,7 @@ int acpiphp_register_attention(struct acpiphp_attention_info *info)
 {
 	int retval = -EINVAL;
 
-	if (info && info->owner && info->set_attn &&
-			info->get_attn && !attention_info) {
+	if (info && info->set_attn && info->get_attn && !attention_info) {
 		retval = 0;
 		attention_info = info;
 	}
