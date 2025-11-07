Return-Path: <linux-pci+bounces-40567-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 24853C3F21B
	for <lists+linux-pci@lfdr.de>; Fri, 07 Nov 2025 10:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7F23F34C51D
	for <lists+linux-pci@lfdr.de>; Fri,  7 Nov 2025 09:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E10B2D949F;
	Fri,  7 Nov 2025 09:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nGZKBUQ7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ohejp7i/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8989229DB99
	for <linux-pci@vger.kernel.org>; Fri,  7 Nov 2025 09:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762507367; cv=none; b=UTqfvTTq6v/78tfAJKKwUPNp2Yo2yxDrpEwANDGCQY//AWAVH3TJQAf0uPTWcTX4u7rDigR5mkywfxeASrRVI1QCMaX6BlT+1EAEJqKq0ujX9WKxbNLQhyet1zJ1pr99Y4yFEawjKrQVpPsn/28RaW6ELJCwZKoVpGVI5KVAb+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762507367; c=relaxed/simple;
	bh=jSV3owYQwj8TXloQjhelaoFvE/YIUYBtRwJXKyKGEz4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iVuNDnproiUJNFP8TBTOzFp1ydHR7vW/8Rj2pdyDIjKrunxcLK7VmzlX2hKUFh9WQ/7iJ70qgqRqcTZpc/PNNqDmR2hv9R70WpbEy0eALuNbKCGqp/2GGMUMrMYN5s8GpxYnP5lHiDHm3fCRcHonM/eL0Led7amLOSQ2+KnJEQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nGZKBUQ7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ohejp7i/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A754GiE2282230
	for <linux-pci@vger.kernel.org>; Fri, 7 Nov 2025 09:22:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=rml7sFCwBBhy1fUJ2Eq4Ln
	8RTDwSlPBGiG+lQMBBTlY=; b=nGZKBUQ7OyvMdtzI9a9YlbKQ+KAZ8N5xJLhHIb
	Q6OZM/e5SMTcs/oosKqnaixAETo7ce0jxklqK3vPoY99sR/8wfXVpmFmay7MH0QG
	0BzDtaKHPCGXb1aXfado5jZgHyVVyzYSc4qR7ZT+Ndd3YAsEmhoZm17GySuLEsji
	gdrM+lSdYy1pJY1OID3EIZgSnF+S20YjSA+hU8J5vLWIYVpRqVx8jCGSkgwAV86f
	Kb23I3zrIUm0MaLsYIwJkd65/I9fHJoENUCVL9lAsHkQmnkg+uRRoZGjeuAvCg5R
	3auhKtf4QDO4DLfWpsp6UxZnvI74bCdy+wBCl18SW33sWjgg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9a9sgpt1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 07 Nov 2025 09:22:43 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-294df925293so7325495ad.2
        for <linux-pci@vger.kernel.org>; Fri, 07 Nov 2025 01:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762507362; x=1763112162; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rml7sFCwBBhy1fUJ2Eq4Ln8RTDwSlPBGiG+lQMBBTlY=;
        b=Ohejp7i/Uv3Xvner5DfV+efEde/7JrsDzKwRQPUMCvjzUVN0WnvWkhsmBp/QBjdAw4
         P2Ax9xfGGJoKKnxRhnAjdUA1s2DpN7PPlZI0mVsveaSyIl7y5M0rhh9p14T+IF0iE0RQ
         /qhkyuQvl89+m6ki33YTWJlhmDySmaP9xeApj2JLu33pF27hHs6bGRPu3jLylT3wqDxb
         1PhR4wzv/eIcSuok6zPl89dMg0u4jBzCGQs19kVWd98fl/1wIcx+fZop/iOf9bS1q8b6
         /n/9eXCsfdB+MKcOwfTQD3rOiAAxkY9xIuRRDVxluHnjiZHM2JSCj7NiY/z/h1xXD+6q
         NAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762507362; x=1763112162;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rml7sFCwBBhy1fUJ2Eq4Ln8RTDwSlPBGiG+lQMBBTlY=;
        b=mldAdUPAJijjqTDGWo0W08dExzpqMWQGBj1zq4BleYYYsV68VNVrP/km+gdacKFre2
         e8qD635LrhhWTKBJDdPD0lGJcMeQIXIDKwEWcqsxfovl3jbcWBoqCYaflzYU1HiYzcHC
         IxQj8wOueXP3Zy+YzzhZObnOBPwGOy2AnphOQvnmcW4jd3HzOQ042Xt03aengZHrkPaX
         GvTH+EwBJgUW7dTglGD09OLWtnEtZR+KJpgnS5vxW0Ln9T34Uoop4TSQuEL2tsCyAc8m
         Tm/JGnpU+MfqWBku9Cry/WfvEPWQ8IGmwIWHKRQyCHx+23CwIM+QDpoOEQ0yxGGVmPwB
         dv6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWztiYnF/wrvjVQ1CvcA2zpz7uIiiqFo5zunV4FsRrjTllw9yq2MbMesRVhpK36WKRT854j7c7Tb9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvrKG/XRrnTXln6gbQw2nO+Wq8NxE690fW19BRwaUHo4AG+kUc
	KTBXCuF1dYPjlxlApu32NnzA/y3BvRJNF16Fr4mji+8mrta2ECrCi9NC/fNoyqPJgFEWNKXxsZY
	ZqH6zoQhPYuQ2N97Ep4Zkdpjp0BCLe6HWXlZkzo+fQ5rD4VNBSeyk7gWv+J46r6Y=
X-Gm-Gg: ASbGncvV2o6dJyMz4h0vuEvYeU0ElYTVjP5JaDfSbJ3+y1UMq4HLUD66TIR4O6pZx1H
	HVsoCcS/kIUOAB+ulWqGATq9z5xqDZUKd25NOrtxRI/fXovLnrgkyehjfmim+OyXvXPlwPvo/PV
	Nyl+UJVh2a52Vb6OeB1PapvcnokhXQLc/QXwHU23ghOWIFdpXZTP++WK63omvVk5+sZzruucJ8h
	gnGdHQmYNm73DnnSrFBckISj3IcmpeZ8seihc8Ndlfug4tEwhzAXklcj0tGny2sfHcaolEJbhwf
	H0V+0vGRX5LhxbJ0V1CH2cjBf0TWncirI98eomFAiD5HBZCt+xIZWsZiceB2xz0f0L3fcMAQNE6
	EJ4RQUf0CblgvoDI155kv10ZFVnzC5Av4UQ==
X-Received: by 2002:a17:903:2f4b:b0:283:c950:a76f with SMTP id d9443c01a7336-297c0478211mr29591985ad.43.1762507362337;
        Fri, 07 Nov 2025 01:22:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHl0iokWVjZuHX3hyllOhwgGfaE3YHg+Yespi4a4AkspVo1v3zvF1j7QcmzRfMeYhZP8G3anw==
X-Received: by 2002:a17:903:2f4b:b0:283:c950:a76f with SMTP id d9443c01a7336-297c0478211mr29591525ad.43.1762507361775;
        Fri, 07 Nov 2025 01:22:41 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c747d1sm53241585ad.63.2025.11.07.01.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 01:22:41 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH v5 0/2] PCI: Add support for PCIe WAKE# interrupt
Date: Fri, 07 Nov 2025 14:52:23 +0530
Message-Id: <20251107-wakeirq_support-v5-0-464e17f2c20c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE+6DWkC/x3MTQqAIBBA4avErBM0FKKrRITZVENQNvYH4t2Tl
 t/ivQgBmTBAU0RgvCnQvmWYsgC32G1GQWM2VLIySkktHrsi8dGHy/udTzEZ7fRgraqdgVx5xon
 e/9h2KX2G6qj0YQAAAA==
X-Change-ID: 20251104-wakeirq_support-f54c4baa18c5
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Pavel Machek <pavel@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com, sherry.sun@nxp.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762507357; l=4617;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=jSV3owYQwj8TXloQjhelaoFvE/YIUYBtRwJXKyKGEz4=;
 b=BII+R3YrkoZan5Xaz3Hzsqqsf61ZQif4/ElY7e1gILB9Bv9xo0hUShekcT+lUcSG1SFm1uGdo
 kNvccKt0i85CxTUkzinLIlzf3Pao28s5Wm3Xmi7hou3+3Y1/O9dq83h
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=CdgFJbrl c=1 sm=1 tr=0 ts=690dba63 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Ikd4Dj_1AAAA:8
 a=s8YR1HE3AAAA:8 a=Ly1ae7BopFzPCSorSWkA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDA3NSBTYWx0ZWRfX+RGAgxzmI2jB
 eAer84GwEjMHfCtQw0c42xAUh5prm9xizTvEaHJC3Gxx4DkmSwzz0JO8wkEpek93S/a1TIKS2SK
 nF7a+6PIrM3Yp6zLBIA3/3IiNhF0PhgVvoLYgm3O1UKpZcotfj/3p9MZ6lpnzBWXTfA896/C7if
 /asRLfWp56f2an8kSk0eUIk0P3x1rBvA8sXi6PmDFoSpGMM5OKMqZTDOeixXhWYKMZilFZZIzsD
 +B9R30gWpjjnKLyCwpm1gwty+KbyKnuK7Nl5LBVupbIs6sOrzoZivs/QN9D/rhZ+MLeVV+BHah0
 iyd+LmXoQn1I5WD0Q5yxILFXr6Ktx0Lmju49bNUh4ux6fIpkapHfVRJk7zLbwL05jdAF5tTRuj1
 rjVw0HIkNmAuuhREAw+dpm9jfTcXvQ==
X-Proofpoint-ORIG-GUID: 9MIBkmMozMn2jv-k9lDcKqvtRCzplsI8
X-Proofpoint-GUID: 9MIBkmMozMn2jv-k9lDcKqvtRCzplsI8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511070075

PCIe WAKE# interrupt is needed for bringing back PCIe device state from
D3cold to D0.

This is pending from long time, there was two attempts done previously to
add WAKE# support[1], [2]. Those series tried to add support for legacy
interrupts along with WAKE#. Legacy interrupts are already available in
the latest kernel and we can ignore them. For the wake IRQ the series is
trying to use interrupts property define in the device tree.

This series is using gpio property instead of interrupts, from
gpio desc driver will allocate the dedicate IRQ.

According to the PCIe specification 6, sec 5.3.3.2, there are two defined
wakeup mechanisms: Beacon and WAKE# for the Link wakeup mechanisms to
provide a means of signaling the platform to re-establish power and
reference clocks to the components within its domain. Beacon is a hardware
mechanism invisible to software (PCIe r7.0, sec 4.2.7.8.1). Adding WAKE#
support in PCI framework.

According to the PCIe specification, multiple WAKE# signals can exist in
a system. In configurations involving a PCIe switch, each downstream port
(DSP) of the switch may be connected to a separate WAKE# line, allowing
each endpoint to signal WAKE# independently. To support this, the WAKE#
should be described in the device tree node of the endpint/bridge. If all
endpoints share a single WAKE# line, then WAKE# should be defined in the
each node.

To support legacy devicetree in direct attach case, driver will search
in root port node for WAKE# if the driver doesn't find in the endpoint
node.

In pci_device_add(), PCI framework will search for the WAKE# in its node,
If not found, it searches in its upstream port only if upstream port is
root port to support legacy bindings. Once found, register for the wake IRQ
in shared mode, as the WAKE# may be shared among multiple endpoints.

When the IRQ is asserted, the handle_threaded_wake_irq() handler triggers
a pm_runtime_resume(). The PM framework ensures that the parent device is
resumed before the child i.e controller driver which can bring back device
state to D0.

WAKE# is added in dts schema and merged based on this patch.
https://lore.kernel.org/all/20250515090517.3506772-1-krishna.chundru@oss.qualcomm.com/

[1]: https://lore.kernel.org/all/b2b91240-95fe-145d-502c-d52225497a34@nvidia.com/T/
[2]: https://lore.kernel.org/all/20171226023646.17722-1-jeffy.chen@rock-chips.com/

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
Changes in v5:
- Enable WAKE# irq only when there is wake -gpios defined in its device
  tree node (Bjorn).
- For legacy bindings for direct atach check in root port if we haven't
  find the wake in the endpoint node.
- Instead of hooking wake in driver bound case, do it in the framework
  irrespective of the driver state (Bjorn).
- Link to v4: https://lore.kernel.org/r/20250801-wake_irq_support-v4-0-6b6639013a1a@oss.qualcomm.com

Changes in v4:
- Move wake from portdrv to core framework to endpoint (Bjorn).
- Added support for multiple WAKE# case (Bjorn). But traverse from
  endpoint upstream port to root port till you get WAKE#. And use
  IRQF_SHARED flag for requesting interrupts.
- Link to v3: https://lore.kernel.org/r/20250605-wake_irq_support-v3-0-7ba56dc909a5@oss.qualcomm.com

Changes in v3:
- Update the commit messages, function names etc as suggested by Mani.
- return wake_irq if returns error (Neil).
- Link to v2: https://lore.kernel.org/r/20250419-wake_irq_support-v2-0-06baed9a87a1@oss.qualcomm.com

Changes in v2:
- Move the wake irq teardown after pcie_port_device_remove
  and move of_pci_setup_wake_irq before pcie_link_rcec (Lukas)
- teardown wake irq in shutdown also.
- Link to v1: https://lore.kernel.org/r/20250401-wake_irq_support-v1-0-d2e22f4a0efd@oss.qualcomm.com

---
Krishna Chaitanya Chundru (2):
      PM: sleep: wakeirq: Add support for custom IRQ flags in dedicated wake IRQ setup
      PCI: Add support for PCIe WAKE# interrupt

 drivers/base/power/wakeirq.c | 43 ++++++++++++++++++++++++++++----
 drivers/pci/of.c             | 58 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h            |  6 +++++
 drivers/pci/probe.c          |  2 ++
 drivers/pci/remove.c         |  1 +
 include/linux/pci.h          |  2 ++
 include/linux/pm_wakeirq.h   |  6 +++++
 7 files changed, 113 insertions(+), 5 deletions(-)
---
base-commit: f04a8f2f1f04a77e65d96f5ee146957522002900
change-id: 20251104-wakeirq_support-f54c4baa18c5

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


