Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBD83330A66
	for <lists+linux-pci@lfdr.de>; Mon,  8 Mar 2021 10:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhCHJkJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 Mar 2021 04:40:09 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:13139 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhCHJkG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Mar 2021 04:40:06 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DvCvD3B6Dz16HjH;
        Mon,  8 Mar 2021 17:38:16 +0800 (CST)
Received: from localhost.localdomain (10.175.102.38) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Mon, 8 Mar 2021 17:39:52 +0800
From:   'Wei Yongjun <weiyongjun1@huawei.com>
To:     <weiyongjun1@huawei.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] PCI: microchip: Make some symbols static
Date:   Mon, 8 Mar 2021 09:48:42 +0000
Message-ID: <20210308094842.3588847-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.102.38]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

The sparse tool complains as follows:

drivers/pci/controller/pcie-microchip-host.c:304:18: warning:
 symbol 'pcie_event_to_event' was not declared. Should it be static?
drivers/pci/controller/pcie-microchip-host.c:310:18: warning:
 symbol 'sec_error_to_event' was not declared. Should it be static?
drivers/pci/controller/pcie-microchip-host.c:317:18: warning:
 symbol 'ded_error_to_event' was not declared. Should it be static?
drivers/pci/controller/pcie-microchip-host.c:324:18: warning:
 symbol 'local_status_to_event' was not declared. Should it be static?

Those symbols are not used outside of pcie-microchip-host.c, so this
commit marks them static.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/pci/controller/pcie-microchip-host.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
index 04c19ff81aff..132631cfe4b6 100644
--- a/drivers/pci/controller/pcie-microchip-host.c
+++ b/drivers/pci/controller/pcie-microchip-host.c
@@ -301,27 +301,27 @@ static const struct cause event_cause[NUM_EVENTS] = {
 	LOCAL_EVENT_CAUSE(PM_MSI_INT_SYS_ERR, "system error"),
 };
 
-struct event_map pcie_event_to_event[] = {
+static struct event_map pcie_event_to_event[] = {
 	PCIE_EVENT_TO_EVENT_MAP(L2_EXIT),
 	PCIE_EVENT_TO_EVENT_MAP(HOTRST_EXIT),
 	PCIE_EVENT_TO_EVENT_MAP(DLUP_EXIT),
 };
 
-struct event_map sec_error_to_event[] = {
+static struct event_map sec_error_to_event[] = {
 	SEC_ERROR_TO_EVENT_MAP(TX_RAM_SEC_ERR),
 	SEC_ERROR_TO_EVENT_MAP(RX_RAM_SEC_ERR),
 	SEC_ERROR_TO_EVENT_MAP(PCIE2AXI_RAM_SEC_ERR),
 	SEC_ERROR_TO_EVENT_MAP(AXI2PCIE_RAM_SEC_ERR),
 };
 
-struct event_map ded_error_to_event[] = {
+static struct event_map ded_error_to_event[] = {
 	DED_ERROR_TO_EVENT_MAP(TX_RAM_DED_ERR),
 	DED_ERROR_TO_EVENT_MAP(RX_RAM_DED_ERR),
 	DED_ERROR_TO_EVENT_MAP(PCIE2AXI_RAM_DED_ERR),
 	DED_ERROR_TO_EVENT_MAP(AXI2PCIE_RAM_DED_ERR),
 };
 
-struct event_map local_status_to_event[] = {
+static struct event_map local_status_to_event[] = {
 	LOCAL_STATUS_TO_EVENT_MAP(DMA_END_ENGINE_0),
 	LOCAL_STATUS_TO_EVENT_MAP(DMA_END_ENGINE_1),
 	LOCAL_STATUS_TO_EVENT_MAP(DMA_ERROR_ENGINE_0),

