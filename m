Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D334E35A87B
	for <lists+linux-pci@lfdr.de>; Fri,  9 Apr 2021 23:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234602AbhDIVwQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Apr 2021 17:52:16 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:26726 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234079AbhDIVwP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Apr 2021 17:52:15 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 139LpHZg030172;
        Fri, 9 Apr 2021 14:51:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=hM0P6oTa0YiBb3d9caveIaX75+Xf+ZvYqQgY9spdLx8=;
 b=CZUrYq0hwH4V9FH838XmSSvXQFnoaLxHct6FigjfQy4v/hnlNyNm+ELb1Zr9UAYZXiZk
 DJuHa60RfP8y3rNUGW5acDVmVbaDL2dQ4p39TENOblGTcctwUreTXUQp7K7+ruvXyLBa
 Pye0/FtpM51N0GsIWMsY5EDMB+az6XfXe9zhgkfXjX6R3/tNqSkV9WfzUzVBA4aELVP7
 /gefIBBR32BxV9ZkcZ+UZCrhm54H1D+bjQgu/kc18MA3p1OR38MwVDRADMOGTF03I+Fr
 IW27RtgEvxb8a1XxYijo4dC0N5MsZOQoz9Apcd8ZATpJ7aatqQ73CR6OL0BUubDOx1ya nw== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 37tftpakp0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 09 Apr 2021 14:51:58 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 9 Apr
 2021 14:51:57 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 9 Apr 2021 14:51:57 -0700
Received: from dut6246.localdomain (unknown [10.112.88.36])
        by maili.marvell.com (Postfix) with ESMTP id 6F9693F703F;
        Fri,  9 Apr 2021 14:51:57 -0700 (PDT)
Received: by dut6246.localdomain (Postfix, from userid 0)
        id 49846228069; Fri,  9 Apr 2021 14:51:57 -0700 (PDT)
From:   Arun Easi <aeasi@marvell.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, Girish Basrur <GBasrur@marvell.com>,
        "Quinn Tran" <qutran@marvell.com>
Subject: [PATCH v2 0/1] PCI/VPD: Fix blocking of VPD data in lspci for QLogic 1077:2261
Date:   Fri, 9 Apr 2021 14:51:52 -0700
Message-ID: <20210409215153.16569-1-aeasi@marvell.com>
X-Mailer: git-send-email 2.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: YFA8Kxcwcuek6qa1gkNE5V5S1GazeHHe
X-Proofpoint-ORIG-GUID: YFA8Kxcwcuek6qa1gkNE5V5S1GazeHHe
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-09_08:2021-04-09,2021-04-09 signatures=0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Please queue this up for the next release.

Change from v1:
    * Commit message modified to add more clarity on the chronology of
      the issues referred as well as justification.

Regards,
-Arun

Arun Easi (1):
  PCI/VPD: Fix blocking of VPD data in lspci for QLogic 1077:2261

 drivers/pci/vpd.c | 1 -
 1 file changed, 1 deletion(-)

-- 
2.9.5

base-commit: ed4d2116b283a1a79e2911c687d83e6b33a462d3
