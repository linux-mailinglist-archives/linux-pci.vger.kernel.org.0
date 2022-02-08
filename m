Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFF34AD19E
	for <lists+linux-pci@lfdr.de>; Tue,  8 Feb 2022 07:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347540AbiBHGfx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Feb 2022 01:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiBHGfw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Feb 2022 01:35:52 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140051.outbound.protection.outlook.com [40.107.14.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663BAC0401EF;
        Mon,  7 Feb 2022 22:35:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWdJk1qPehbmxozNfWDgbNp6LtIV90BZM7Fhc+duJiviN1+qd06NSlwcDKSuJ+CpzWk0M3UIRd9DIx5q5swY8c3tR9qpbAAxt43ubI6EMsg8+9y1g6LA/9ncXcLOLgmNkVSCaGmRJux4fdJgJeajAVLf1Nsz/hj2Zh3nVEbfLKBsZGD5cM/BXsTpKu6xy1JAe0tKTat/dcVmXzc2r03No19jjkn+h47aTfZ9hyM0eFMKC/lDx+WyFa9ydZdFke2pQIObtLXf+KKX0sB1IzBRxa3zv/ziamwD7Z7J2sA7KPEeqv++BtlKuO/WyeGRGEygowpuZnoBZsmIn473EXEk0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VG5hSbToDLcCAM584bkWIo4Qu/8Qzj6akuSYdCTWTaU=;
 b=LU0OinHRDYplM76fR6fiahbpOjaJXRbO5NWY/J+0BTv2swULCODstbLLJ+Ph+Wf2g+5h75rjIqjwvtDLmVkB7ld9iNsLCvAoebCQwiO8+o9JR00t/wwLO2cMIUpp2zZPISKtL9684bWRdZxjy8otBITHLU6kKhDS2gVIGL+IvULP+8io2rNNllM18PNVZbFSOuCSGmbIYUQbbwTDYYuIxdQ3bx5XkBB+4z3mAGNas6QzTguXkJaU2Dr7eqGXdvyVRESlV/ZXgYntED8YO+LE34a4iISAAm1LCqR7DEXK5AXVT329+EOtnGTFkbcGtY8Y0bapXWre59D89GXOd5pPow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=kernel.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VG5hSbToDLcCAM584bkWIo4Qu/8Qzj6akuSYdCTWTaU=;
 b=iCCsH6+e4uAf/4PHWl8xAGDMhfKDiYhs2GKKr5+FG3QVYU0GCUEfjaHEkhFEEtE28qa8bWoACEiN4jG/95Xrv5em/y4GYwDMPpvi6nZdYRNm0x7gemLTa8GNKmU1bXTOq1v5wg2+/SGqOS50V4Q4xS0Rb9jPKNRo+CIjcenyR+hR9N3n1bVRyK4H+Kh/U2G5L8vNCu7lloNFR7FWsBGqX3e89cVfnB6FTmkRl4boniBO/iblLje4k6oukRrWSK5YjZN2Zakdx+YfxIhKM/cjmfnFjJ9XzDyF10z4KmlIJvD997zV8wr5BZXtLZStjYRCHJRMKrSC1o8G4rqOPhpqWg==
Received: from SV0P279CA0036.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:12::23)
 by AM0PR10MB2019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:4a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Tue, 8 Feb
 2022 06:35:45 +0000
Received: from HE1EUR01FT019.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:f10:12:cafe::49) by SV0P279CA0036.outlook.office365.com
 (2603:10a6:f10:12::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Tue, 8 Feb 2022 06:35:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.71) by
 HE1EUR01FT019.mail.protection.outlook.com (10.152.0.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Tue, 8 Feb 2022 06:35:44 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Tue, 8 Feb 2022 07:35:44 +0100
Received: from [167.87.73.1] (167.87.73.1) by DEMCHDC8A0A.ad011.siemens.net
 (139.25.226.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 8 Feb
 2022 07:35:43 +0100
Message-ID: <d63a4a41-6289-e3ba-cccb-b0dcbed60c79@siemens.com>
Date:   Tue, 8 Feb 2022 07:35:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [Bug 215533] [BISECTED][REGRESSION] UI becomes unresponsive every
 couple of seconds
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
CC:     <joey.corleone@mail.ru>, <linux-kernel@vger.kernel.org>
References: <20220207224540.GA425996@bhelgaas>
From:   Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220207224540.GA425996@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.73.1]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea3e46f4-540f-4ad4-e51e-08d9eacd3c06
X-MS-TrafficTypeDiagnostic: AM0PR10MB2019:EE_
X-Microsoft-Antispam-PRVS: <AM0PR10MB201911C110FBA4F11DEFF844952D9@AM0PR10MB2019.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lNDy0RbIF03T3e0nM0apYpOqe6n8zKTGVXtkADdAGuvVLYl6byIarQz3S/HiQxd2UWIH0mC4Gzol8wPNMNMU6/vB/1XHjGs5OoS43e+qv9aBVkxRb+528UzZdrIlQ3k5r0x4tGW4/932yfN9AKJmfRo6qvgiP82cZwC3BcGMvQI09rwKuD0HYqoaRT0Jagv3TmUxB3Hfb02yeupSM9oCHsNMeO4p7k0fuBYE9stzj7Gkck2eEJSIlQ5vOCkAoI7pN7IM0P8gpcN2AaHZj2LSWtV/0Z4uc7QCE6TfgkqlJQEZrGk+pVMpLJ7VCpYCP7O24QwODJZHq0H1ZArAWIadPtUTQkimkKE2GPPxD+QDto6dW1a0JFJkxgD20soQi9X47jJ+M5opgd9zoeYh48iqo7VCi8+J2wAxSzWRRCvF/SgPf2YT9mntpZWr6Ra4oNCAjZuTspgoZ2hGHjjyvY8jTDXE4zoRj1Kqlmnq7C83eXGsxmP03IjtqK3fjP4/b1bDXMzCmiurxfjSoignm3pHPxTZgha1phtxcEZHXG44jnJdpB25rqLxsfXshKydVgigwHzkNBE0HIymShS0fPkEfY//tWEUYphUmfq+bKfyNgXTGIrL6/oJoJjSg8VIFeagTZawasnbD4848qeT31MordoW/MBD1G3opHK4IsI6D1kYEoQ1HTJzHilUlHlwwGR4NkMC97dk75lhHylEmcw4834mNECFouk2CMAYcTVbxhGywf4bZlQZE6qG1w5xEOjysuGvEOvR9OhdHWF50tQ3eSjSyS/teR+8Mhp9T/Vz4u8vQJtzAMdq0D3+r2FH3tDS+cbgxIdrn4hIsOYzGSBZs3BD9M5TqS10u6wkT6kK/WTqHQVfX6GHrBhtVvBVqqOB
X-Forefront-Antispam-Report: CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(16526019)(2616005)(53546011)(186003)(26005)(316002)(83380400001)(356005)(36860700001)(82310400004)(47076005)(44832011)(956004)(336012)(8936002)(40460700003)(4326008)(8676002)(86362001)(2906002)(508600001)(966005)(16576012)(6706004)(70206006)(70586007)(54906003)(81166007)(31696002)(36756003)(16799955002)(82960400001)(31686004)(5660300002)(110136005)(241875001)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 06:35:44.5134
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea3e46f4-540f-4ad4-e51e-08d9eacd3c06
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT019.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2019
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 07.02.22 23:45, Bjorn Helgaas wrote:
> [+cc linux-kernel for visibility]
> 
> On Wed, Jan 26, 2022 at 06:12:50AM -0600, Bjorn Helgaas wrote:
>> On Wed, Jan 26, 2022 at 08:18:12AM +0000, bugzilla-daemon@bugzilla.kernel.org wrote:
>>> https://bugzilla.kernel.org/show_bug.cgi?id=215533
>>>
>>> --- Comment #1 from joey.corleone@mail.ru ---
>>> I accidentally sent the report prematurely. So here come my findings:
>>>
>>> Since 5.16
>>> (1) my system becomes unresponsive every couple of seconds (micro lags), which
>>> makes it more or less unusable.
>>> (2) wrong(?) CPU frequencies are reported. 
>>>
>>> - 5.15 works fine.
>>> - Starting from some commit in 5.17, it seems (1) is fixed (unsure), but
>>> definitely not (2).
>>>
>>> I have bisected the kernel between 5.15 and 5.16, and found that the offending
>>> commit is 0e8ae5a6ff5952253cd7cc0260df838ab4c21009 ("PCI/portdrv: Do not setup
>>> up IRQs if there are no users"). Bisection log attached.
>>>
>>> Reverting this commit on linux-git[1] fixes both (1) and (2).
>>>
>>> Important notes:
>>> - This regression was reported on a DELL XPS 9550 laptop by two users [2], so
>>> it might be related strictly to that model. 
>>> - According to user mallocman, the issue can also be fixed by reverting the
>>> BIOS version of the laptop to v1.12.
>>> - The issue ONLY occurs when AC is plugged in (and stays there even when I
>>> unplug it).
>>> - When booting on battery power, there is no issue at all.
>>>
>>> You can easily observe the regression via: 
>>>
>>> watch cat /sys/devices/system/cpu/cpu[0-9]*/cpufreq/scaling_cur_fre
>>>
>>> As soon as I plug in AC, all frequencies go up to values around 3248338 and
>>> stay there even if I unplug AC. This does not happen at all when booted on
>>> battery power. 
>>>
>>> Also note: 
>>> - the laptop's fans are not really affected by the high frequencies.
>>> - setting the governor to "powersave" has no effect on the frequencies (as
>>> compared to when on battery power).
>>> - lowering the maximum frequency manually works, but does not fix (1).
>>>
>>> [1] https://aur.archlinux.org/pkgbase/linux-git/ (pulled commits up to
>>> 0280e3c58f92b2fe0e8fbbdf8d386449168de4a8).
>>> [2] https://bbs.archlinux.org/viewtopic.php?id=273330
> 
> I hope we can find a better solution, but since the responsiveness
> issue is a significant regression, I queued up a revert of
> 0e8ae5a6ff59 ("PCI/portdrv: Do not setup up IRQs if there are no
> users") in case we don't find one.

Likely best for now.

> 
> If/when we get to the bottom of this, I'll replace the revert with the
> solution.  0e8ae5a6ff59 appeared in v5.16, so we'll have to make sure
> we fix that as well.

If you could give some feedback/hints on the questions I posted last
week on the original patch, that might accelerate understanding the real
issue.

Thanks,
Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux
