Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6CD3327E6
	for <lists+linux-pci@lfdr.de>; Tue,  9 Mar 2021 14:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhCIN44 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Mar 2021 08:56:56 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:13077 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbhCIN4l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Mar 2021 08:56:41 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DvxXJ2ln6zNkQR;
        Tue,  9 Mar 2021 21:54:24 +0800 (CST)
Received: from linux-ioko.site (10.78.228.23) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Tue, 9 Mar 2021 21:56:34 +0800
From:   Dongdong Liu <liudongdong3@huawei.com>
To:     <mj@ucw.cz>, <helgaas@kernel.org>, <kw@linux.com>,
        <linux-pci@vger.kernel.org>
Subject: [PATCH V2 0/2] lspci: Decode VF 10-Bit Tag Requester
Date:   Tue, 9 Mar 2021 21:35:17 +0800
Message-ID: <1615296919-76476-1-git-send-email-liudongdong3@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.78.228.23]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The patchset is to decode VF 10-Bit Tag Requester and
update the tests files.

V1->V2: Fix comments suggested by Krzysztof Wilczyński.

Dongdong Liu (2):
  lspci: Decode VF 10-Bit Tag Requester
  lspci: Update tests files with VF 10-Bit Tag Requester

 lib/header.h        | 2 ++
 ls-ecaps.c          | 8 ++++----
 tests/cap-dvsec-cxl | 4 ++--
 tests/cap-ea-1      | 4 ++--
 tests/cap-pcie-2    | 4 ++--
 5 files changed, 12 insertions(+), 10 deletions(-)

--
1.9.1

