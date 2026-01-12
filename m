Return-Path: <linux-pci+bounces-44460-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF48D10674
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 04:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF5F0300E832
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 03:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB07630498E;
	Mon, 12 Jan 2026 03:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="aGcw30CE"
X-Original-To: linux-pci@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA4D306B05
	for <linux-pci@vger.kernel.org>; Mon, 12 Jan 2026 03:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768186903; cv=none; b=jpDOcyHGXPWoue3z4sQJPF27NfCV9na38niMSbvtv3dqIPcjyWhQ2gD0mUpDN+/KZBk3D8XJXBgk78JVKWAHmYZ608//19z+Ufw0TBzfzn4G+JCcB3KKZFWsbSLnsxuR4odlFJTiusYPyg4keTyJa1OlEK/qybG/SAyIRb/1Apo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768186903; c=relaxed/simple;
	bh=qG6dXOpBZNFWOEOpxMatYW+hg5h5XbksYXWBdtvNm4g=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:CC:Content-Type; b=nChx1v3je3kzu3QLzu2RallCOIpbgntVEoS3Lr7ybWSPCw7lDKA1ax+I9mFsx01+dckb44tjqMBEK5O/t2K44uMuPtslRsja4YkKAGnEIy0VhzBYkzhqElLRio+Ods2soBwm1YOShcHoWRGUQ8VqTKoQRar7oNyZIxkF/2nxB+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=aGcw30CE; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Hv95OtTcY8ro07ZoCYuf85nIeKGFnZMzCcmh5C5sDuo=;
	b=aGcw30CEBys+rVkbLB1PPCdjMlP6zZYB9EB+SMtXeaPO8Lm8QxrxFRA6IlgmJD3HW2XlNIf9R
	BA81VXdPllbKCz/4yFXoDsS3d59iZsFgiqI1Q2t4ydI1RDRpHt1siegWCU9o+nlzTbsb+1FQ4+0
	ncB1LHaDv7muk5trqlJTMc4=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4dqH9f3CLlz1T4Jx;
	Mon, 12 Jan 2026 10:57:42 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 1CE094056E;
	Mon, 12 Jan 2026 11:01:32 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 12 Jan 2026 11:01:31 +0800
Message-ID: <0cba9df3-8fe5-47ef-929c-6da64d31bf69@huawei.com>
Date: Mon, 12 Jan 2026 11:01:31 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: <linux-pci@vger.kernel.org>
From: fengchengwen <fengchengwen@huawei.com>
Subject: RFC about how to obtain PCIE TPH steer-tag on ARM64 platform
CC: Wei <wei.huang2@amd.com>, <Eric.VanTassell@amd.com>,
	<bhelgaas@google.com>, <jonathan.cameron@huawei.com>,
	<wangzhou1@hisilicon.com>, <wanghuiqiang@huawei.com>,
	<liuyonglong@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk500009.china.huawei.com (7.202.194.94)

Hi all,

We want to enable PCIE TPH feature on ARM64 platform, but we encounter the
following problem:
1. The pcie_tph_get_cpu_st() function invokes the ACPI DSM method to obtain
   the steer-tag of the CPU. According to the definition of the DSM method [1],
   the cpu_uid should be "ACPI processor uid".
2. In the current implementation, the ACPI DSM method is invoked directly using
   the logical core number, which works on the x86 platform but does not work
   on the ARM64 platform because the logical core ID is not the same as the
   ACPI processor ID when the PG exists.


Because the ARM64 platform generates steer-tag based on the MPIDR information
(at least for the Kunpeng platform). Therefore, we have two option:
Option-1: convert logic core ID to ACPI process ID: use get_acpi_id_for_cpu()
          to get ACPI process ID in pcie_tph_get_cpu_st() before invoke dsm [2],
          and BIOS/ACPI use process ID to get corresponding MPIDR, and then
          generate steer-tag from MPIDR.
Option-2: convert logic core ID to MPIDR: use cpu_logical_map() to get MPIDR
          in pcie_tph_get_cpu_st() before invoke dsm, and BIOS/ACPI use it
          to generate steer-tag directly.

Option-1 complies with _DSM ECN, but requires BIOS/ACPI to maintain a mapping
table from acpi_process_id to MPIDR.
Option 2 does not comply with _DSM ECN (if extension is required). But it is easy
to implement and can be extended to the DT system (ACPI is not supported) I think.


Hope for your feedback.

With best regards,
Chengwen


[1] According to _DSM ECN, the input is defined as: "If the target
    is a processor, then this field represents the ACPI Processor UID of the
    processor as specified in the MADT. If the target is a processor
    container, then this field represents the ACPI Processor UID of the
    processor container as specified in the PPTT"
[2] git diff about /drivers/pci/tph.c
@@ -289,6 +289,9 @@ int pcie_tph_get_cpu_st(struct pci_dev *pdev, enum tph_mem_type mem_type,

        rp_acpi_handle = ACPI_HANDLE(rp->bus->bridge);

+#ifdef CONFIG_ARM64
+       cpu_uid = get_acpi_id_for_cpu(cpu_uid);
+#endif
        if (tph_invoke_dsm(rp_acpi_handle, cpu_uid, &info) != AE_OK) {
                *tag = 0;
                return -EINVAL;



