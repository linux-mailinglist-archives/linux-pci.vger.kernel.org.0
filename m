Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070F166949C
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jan 2023 11:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbjAMKtT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Jan 2023 05:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241126AbjAMKqs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jan 2023 05:46:48 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2103.outbound.protection.outlook.com [40.107.102.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7637E59F80;
        Fri, 13 Jan 2023 02:46:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+ZdOxCVBlCCmvkqbNkqfLij0CGwB6q1ZEfRMav0jIP/4RJSiXA4et0Q2ZD/Jqxy3+aHk7/dY2aMCWwps+PtK0+gOXJPCd6u7obA8efl8D1XtRnKbBj3pCe7mO8KgoTMhWpBtvB/9C00E51SnUuqGJqPlus5BEHOTnqN38J42j1uY8JsOdmfQDwekbKSoPFmbX5n0BbyO0DykUf7Ngoikc6xM2Cg0nmppM8RDb8GqLjFrFa/XGL44icG4hnHwdAoVaMMN3XLmGL7sgYShULZeyIBLadE9pGxrYvtE2Bm3aMaSz9mwbKo+BoKbwVOWWbOVamaClf0ZGpKeGt21FIqLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmGJpEUEdnUY974D8oLlvd4SfiBs4vvllvqV6aUFL8s=;
 b=Tf5KYlInosdqyVnnsxwjq0ifOsFoKuZNG+1wJMKIxvCcU4WWzpTGW8RcJDPd4g3g3n1/yt61V9TEfAN3QhkvgRWtuJsXHYpfckz73s6YBQ65zEEGr4HMRI+ot80sz+IPJgRUcRSNsrGWfTubJ+KMR+ixiXcDIuEv5jKt2FSXchqOG8g35F4b+KrpVYFD8oxyONpmXL8kN2BRe5jIiB+n8BndL2g22lT97+RghZnh/HaJl445hiveaN5w9yhjTTAmoq524E9SkfvEnJ2tTPjMSfRwm0jAHXES94PGuZxcy9esACNrsIvWrMc4cyOx4Y/omW3tcR9TKdKJZp/50T1DTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmGJpEUEdnUY974D8oLlvd4SfiBs4vvllvqV6aUFL8s=;
 b=UDMdk6QLsdwd8Jnncsyn+8qMkE3D4Y1oqIR8WBq/jAwg6JWj98lJwU1UZYTHJ51eB6qxi8ECb7LnD7HuCF7hu1b4dRzaJwVm5X05Yr+gJAThu8G2qtIe/JchH+AjZDiIyhiTqbWbWdcqgbqQEo74sxLTUiB2BFrJPPydAJ4FLOk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM5PR1301MB2172.namprd13.prod.outlook.com (2603:10b6:4:2d::21)
 by CO6PR13MB5324.namprd13.prod.outlook.com (2603:10b6:303:14b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Fri, 13 Jan
 2023 10:46:15 +0000
Received: from DM5PR1301MB2172.namprd13.prod.outlook.com
 ([fe80::290c:8cf1:86c8:89e0]) by DM5PR1301MB2172.namprd13.prod.outlook.com
 ([fe80::290c:8cf1:86c8:89e0%7]) with mapi id 15.20.5986.018; Fri, 13 Jan 2023
 10:46:15 +0000
From:   Baowen Zheng <baowen.zheng@corigine.com>
To:     helgaas@kernel.org
Cc:     2lprbe78@duck.com, benoitg@coeus.ca, bhelgaas@google.com,
        hdegoede@redhat.com, kernelorg@undead.fr, kjhambrick@gmail.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        mika.westerberg@linux.intel.com, mumblingdrunkard@protonmail.com,
        nicholas.johnson-opensource@outlook.com.au,
        wse@tuxedocomputers.com, simon.horman@corigine.com,
        yinjun.zhang@corigine.com, tianyu.yuan@corigine.com
Subject: Re:[PATCH v2 1/4] efi/x86: Remove EfiMemoryMappedIO from E820 map
Date:   Fri, 13 Jan 2023 18:46:03 +0800
Message-Id: <1673606763-30159-1-git-send-email-baowen.zheng@corigine.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <20221208190341.1560157-2-helgaas@kernel.org>
References: <20221208190341.1560157-2-helgaas@kernel.org>
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:195::12) To DM5PR1301MB2172.namprd13.prod.outlook.com
 (2603:10b6:4:2d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR1301MB2172:EE_|CO6PR13MB5324:EE_
X-MS-Office365-Filtering-Correlation-Id: 778fd6c6-2363-4111-cf81-08daf5536505
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y+L8KmtXeV8zDoA7Ul6p8+c+s2td/Ktps4uOu2iExwsAzEEZ3hJonpx9Kh+0OnEVW3b+KuehuENZdK4GnRoixRVBDmU6igt3buxjFm/NZaQqe9GjeEW7AlT7XJVZtDJYNSb1yVTymse3QJ4c1epZuK+hWrOiRArkHlIYcsT0cE/rKuIp0ZszE6BjAQxazDCx5yEMCi8eezd8J4yuyvVpBreMe/qbc5FIi1KwRXNfuJ3YucggrgZ4CL4cSPwPuM0hpuOjH3uYh+dU1pajXtJv+QRMeX5g1AOmStAHUjNqy5cpRFSl9ebR3gt1tQUa0727gVlcS9ddl7MxCbfiIUe90Rt7fd//FAqKSj3PVWR0VIuwcoaNNBVKK/gRC0sQWBFh2VPWJKjd7tNmz1j+xrLhmbTpAj0/XeAR440+mlO1qnS7x3ox7aeQDVYNiHQLgOtdEeWvaayez9zISFq1AG6QE1ZW8WdnpX/3xRrgv2/FOSjw3GgPDlM+yOcu+UVCKwHSuGrBjwrJ7NOLkPuqxWNHPxFG9PpUOm2ET0JS5L9/DaXSO8vIR5AOSeFZSDxMXNfQFP2UEXlEUGjE/jZOwGhsrz5gpQIiVCQTlKbbf85MJ2bXCtqB8l0GQbb1DmdM6UN8dHw/Olji8A8IkO9wLBDrIVlZdBGcwx1jG1KPHyyl/z1zMr0BaLhC2jzwrINNic/U6RG1anU4fFr/FKTwnY/G5SKt6V313uNQXC1+UjAw8To=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1301MB2172.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39830400003)(376002)(396003)(366004)(451199015)(6486002)(966005)(316002)(52116002)(44832011)(2906002)(36756003)(7416002)(5660300002)(8936002)(66556008)(66946007)(66476007)(8676002)(41300700001)(4326008)(6916009)(86362001)(83380400001)(38350700002)(38100700002)(26005)(6512007)(186003)(478600001)(6666004)(107886003)(6506007)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gJF1ZOwSOBnvLc149AavokwosTIYDJHxhmFjP/f22Ltvop2GMXKDZCldAi//?=
 =?us-ascii?Q?wNOe4Dwrz6eAbOkDdY5mL/+nsathifndJPQAWP7wYmiJe8ypa5wo9ztAQ1Rr?=
 =?us-ascii?Q?uxoxhMcva9jAbr2FsQ1AcQleBMcQrNSFFMPs6VkpnDTVzqMckcCqqHgX02e8?=
 =?us-ascii?Q?PrmI1SRckVuwQZ7ifxU1DjnNpEnZubOSXKhCpbHCRfyPBU7VFKX/yWrS04lQ?=
 =?us-ascii?Q?A/85wPEj1iqqQfqrNV2BjWPerGBo5ZncJQYOM9eKn0CMFKWvgOF8zn7qyiiw?=
 =?us-ascii?Q?1vQvOyhiA2ZhBixurPr/Qkv8LDIqQXrX6XKQW62W9obaGJjTyRkcTbXUak7+?=
 =?us-ascii?Q?ZAIerDB6iFWSNKcVuv7zZLzORdPzwNUwIRasz4ZLo+9a0l4Xg6HwAgQiIaRV?=
 =?us-ascii?Q?vfH3Yt9UhA172eMLlAVGyOyxqYpjcSeyFh0NUuYpexmSuyHDYQXlJEa/i9ny?=
 =?us-ascii?Q?gyRLJU0LRxXJxRrj7EqLRIscC257V+EK+VEYQ6lq1q+VLPT5r08Mqb1oVruY?=
 =?us-ascii?Q?Xqy7vg4aka5OPGkNQ3jWQMJm1TUquyJtf8gOPt9bFLvk2ZXE9DDYLWthYGaD?=
 =?us-ascii?Q?aF45MyLX741pl1vaNSbdDYFkEgZLnbjtfLakX2bNIrWvxIcVd8KmZmx8Tm6l?=
 =?us-ascii?Q?CFuaofq5S3sGlt1ZVJw9GgECTA52QYZh7r4dAJuC82FCalbDorH1TFMypfOv?=
 =?us-ascii?Q?zwnXqEJB0/zWm3VQuCBdCepVvtVeI47DNx9FIN9wPtsrYp/inDGwQnPXDqqF?=
 =?us-ascii?Q?iyYB7lTuMGetS3BsrlCL7ff+tKI7fwhItqQ0/69/5AUWVT4ONJ6o/d8dhZmE?=
 =?us-ascii?Q?gUUIFep7b9Z6DnWqM8Wmmk2ck5ZvoftsjGiwu2UpCQqeuCYjbb+BfmLthp5p?=
 =?us-ascii?Q?WfOCE8nuZfDEvwft6UdGjHVF4bLjHWpDYBrLEwIGaLDmQfwBvvtS36DcOnh4?=
 =?us-ascii?Q?6YxWoByquOZv/BJgYwMklX5S9AH1LRjb9VblxxaRLjQMb11twrzgyfUpDtgN?=
 =?us-ascii?Q?ZyLRjE4o8l8AvmzmKk9EF7PmIh3PxoaL5niXP5dtUaQLQA92L2XaYRVClz7g?=
 =?us-ascii?Q?CF+H+wPSoqyLHfsMbQ3rzUT7bXghYuS8oWrkZiAtg0EwjKZA/L0X5jwu0p5n?=
 =?us-ascii?Q?y3VzBfc40HAxDGd4pJNVY728WSe24vlBoCTsatFAuqzHj/6JmgKmxNqPjEvj?=
 =?us-ascii?Q?C7RdGEyXICJOaWENqzKxo49nlBKw+RyOd0X4wiVShG2J4fXfn0m98Gx/ppcO?=
 =?us-ascii?Q?+qX5y4WMZSmt3kesjUKYDneWlXosM8Pa8lXW8FIo2t3xaVeG3HFqVvFOE5XT?=
 =?us-ascii?Q?qIDtvV4Zs9ry1/vND+nwFBBHjKZxHORk1eyiEsqghjKFnuJbXF+0srLmG83u?=
 =?us-ascii?Q?Xgol6OeTXB6ca3FHefoVlgpE+CRfuOOuZ7QiUFbT3oDfQ8Ip7hwzzr5sRy1d?=
 =?us-ascii?Q?PYpczEUgQThku2frQ3NKdbEr32VGqmbeixTReZrcaZcHy1cr7mi5rdcDXEPG?=
 =?us-ascii?Q?xx5HI7IMxmfGZzTA9bSMOB/pmXp+h06i/9Ckkqqw8cddZg9rTosivbvtGFDy?=
 =?us-ascii?Q?KfZM57NFk6v1TkRAv4mlY/1xCtOGBgAJMvmE6j6KMAfwH+krdThdcX57iY/T?=
 =?us-ascii?Q?DA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 778fd6c6-2363-4111-cf81-08daf5536505
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1301MB2172.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 10:46:15.6379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kIb5wbDLxAkKlrBedWL5skg5ZCSewvLzFib5EKYOO/OxWhy/W6TG25fROnZlv7OiFNOnQwPlx6P8+mS7n9LNckMjJjM38l0oAnWVFC8o0OY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR13MB5324
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Bjorn Helgaas:

When we tested our NIC, we found we will fail to access pcie extent configuration space.
Actually we can only access the 256 Bytes of the pcie configuration space.
You can make check with command of "lspci -s XXXX -vv"
It seems relates to this change, could you please help to make a check?


On Thu, 8 Dec 2022 13:03:38 Bjorn Helgaas wrote:
>Firmware can use EfiMemoryMappedIO to request that MMIO regions be mapped
>by the OS so they can be accessed by EFI runtime services, but should have
>no other significance to the OS (UEFI r2.10, sec 7.2).  However, most
>bootloaders and EFI stubs convert EfiMemoryMappedIO regions to
>E820_TYPE_RESERVED entries, which prevent Linux from allocating space from
>them (see remove_e820_regions()).
>
>Some platforms use EfiMemoryMappedIO entries for PCI MMCONFIG space and PCI
>host bridge windows, which means Linux can't allocate BAR space for
>hot-added devices.
>
>Remove large EfiMemoryMappedIO regions from the E820 map to avoid this
>problem.
>

...

>
>Link: https://bugzilla.kernel.org/show_bug.cgi?id=216565     Clevo NL4XLU
>Link: https://bugzilla.kernel.org/show_bug.cgi?id=206459#c78 Clevo X170KM-G
>Link: https://bugzilla.redhat.com/show_bug.cgi?id=1868899    Ideapad Slim 3
>Link: https://bugzilla.redhat.com/show_bug.cgi?id=2029207    X1 Carbon
>Reported-by: Florent DELAHAYE <kernelorg@undead.fr>
>Tested-by: Konrad J Hambrick <kjhambrick@gmail.com>
>Tested-by: Matt Hansen <2lprbe78@duck.com>
>Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>Cc: Hans de Goede <hdegoede@redhat.com>
>---
> arch/x86/platform/efi/efi.c | 46 +++++++++++++++++++++++++++++++++++++
> 1 file changed, 46 insertions(+)
>
>diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
>index ebc98a68c400..dee1852e95cd 100644
>--- a/arch/x86/platform/efi/efi.c
>+++ b/arch/x86/platform/efi/efi.c
>@@ -303,6 +303,50 @@ static void __init efi_clean_memmap(void)
> 	}
> }
> 
>+/*
>+ * Firmware can use EfiMemoryMappedIO to request that MMIO regions be
>+ * mapped by the OS so they can be accessed by EFI runtime services, but
>+ * should have no other significance to the OS (UEFI r2.10, sec 7.2).
>+ * However, most bootloaders and EFI stubs convert EfiMemoryMappedIO
>+ * regions to E820_TYPE_RESERVED entries, which prevent Linux from
>+ * allocating space from them (see remove_e820_regions()).
>+ *
>+ * Some platforms use EfiMemoryMappedIO entries for PCI MMCONFIG space and
>+ * PCI host bridge windows, which means Linux can't allocate BAR space for
>+ * hot-added devices.
>+ *
>+ * Remove large EfiMemoryMappedIO regions from the E820 map to avoid this
>+ * problem.
>+ *
>+ * Retain small EfiMemoryMappedIO regions because on some platforms, these
>+ * describe non-window space that's included in host bridge _CRS.  If we
>+ * assign that space to PCI devices, they don't work.
>+ */
>+static void __init efi_remove_e820_mmio(void)
>+{
>+	efi_memory_desc_t *md;
>+	u64 size, start, end;
>+	int i = 0;
>+
>+	for_each_efi_memory_desc(md) {
>+		if (md->type == EFI_MEMORY_MAPPED_IO) {
>+			size = md->num_pages << EFI_PAGE_SHIFT;
>+			if (size >= 256*1024) {
>+				start = md->phys_addr;
>+				end = start + size - 1;
>+				pr_info("Remove mem%02u: MMIO range=[0x%08llx-0x%08llx] (%lluMB) from e820 map\n",
>+					i, start, end, size >> 20);
>+				e820__range_remove(start, size,
>+						   E820_TYPE_RESERVED, 1);
>+			} else {
>+				pr_info("Not removing mem%02u: MMIO range=[0x%08llx-0x%08llx] (%lluKB) from e820 map\n",
>+					i, start, end, size >> 10);
>+			}
>+		}
>+		i++;
>+	}
>+}
>+
> void __init efi_print_memmap(void)
> {
> 	efi_memory_desc_t *md;
>@@ -474,6 +518,8 @@ void __init efi_init(void)
> 	set_bit(EFI_RUNTIME_SERVICES, &efi.flags);
> 	efi_clean_memmap();
> 
>+	efi_remove_e820_mmio();
>+
> 	if (efi_enabled(EFI_DBG))
> 		efi_print_memmap();
> }
