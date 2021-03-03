Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B782732C8F2
	for <lists+linux-pci@lfdr.de>; Thu,  4 Mar 2021 02:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236582AbhCDA7P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Mar 2021 19:59:15 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:42412 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1354293AbhCDAH6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Mar 2021 19:07:58 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 123MUlVL014392;
        Wed, 3 Mar 2021 14:42:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=3Rtq+mYaWUizuUOqOCLWl1taTBxP0x0Hz30+OhNVEh4=;
 b=BMompRfRbbKKzyXnljs9o3MgiWOVJieAqV3/AHkD41vkenyWWFCVIavYZ1xNMVKBVtqt
 r+doouLRgpQKLDliUlEIdrwOiV3/3Eg+VfcPw/m0AsOx9rhxMuQ0QB/kfc1X3VgYR0a5
 3mUwRISnx8mU4cnmrM7tWHn/Ijsww62WBgGgzDhlaQVoBmBDt0bMmy4uiA/prEqe51LQ
 hnux2ooFiJC6EYb1YeG6Z608tmD6OtIzvWr67y4AyXmvUj/dHmhdj99DJ6uuox9/vOBz
 MUGLWDAqoaGQjnu+l7E/pzpgnKdWXa76RVThHmQ+MgGuHopWbTZHyf6J/q3Nuh9SZnjB SA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 36ymaueup7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 03 Mar 2021 14:42:57 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 3 Mar
 2021 14:42:55 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 3 Mar 2021 14:42:55 -0800
Received: from dut6246.localdomain (unknown [10.112.88.36])
        by maili.marvell.com (Postfix) with ESMTP id F24F43F7040;
        Wed,  3 Mar 2021 14:42:55 -0800 (PST)
Received: by dut6246.localdomain (Postfix, from userid 0)
        id D7747228064; Wed,  3 Mar 2021 14:42:55 -0800 (PST)
From:   Arun Easi <aeasi@marvell.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, Girish Basrur <GBasrur@marvell.com>,
        "Quinn Tran" <qutran@marvell.com>
Subject: [PATCH 0/1] PCI/VPD: Fix blocking of VPD data in lspci for QLogic 1077:2261
Date:   Wed, 3 Mar 2021 14:42:49 -0800
Message-ID: <20210303224250.12618-1-aeasi@marvell.com>
X-Mailer: git-send-email 2.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-03_07:2021-03-03,2021-03-03 signatures=0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

As discussed, re-sending the patch with updated commit message.
You can disregard the earlier patch titled:

	"[PATCH] PCI/VPD: Remove VPD quirk for QLogic 1077:2261"

Regards,
-Arun

Arun Easi (1):
  PCI/VPD: Fix blocking of VPD data in lspci for QLogic 1077:2261

 drivers/pci/vpd.c | 1 -
 1 file changed, 1 deletion(-)

-- 
2.9.5

base-commit: e18fb64b79860cf5f381208834b8fbc493ef7cbc
