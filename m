Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33226FDBE0
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2019 12:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfKOLAR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Nov 2019 06:00:17 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49658 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfKOLAR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Nov 2019 06:00:17 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAFB0CrW104301;
        Fri, 15 Nov 2019 05:00:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573815612;
        bh=GwOZ602lIeN8coFOi+lA6QyuwKWfAUN6uVVTyrPlXcM=;
        h=From:Subject:To:Date;
        b=B6GmCJd2qRA656hhHrOVEPIoyRP90YEeUTAgM5i4CkHiFaNr8uiTmt1N8Cbh3V3i0
         XMwjIoiKumXws5wZPYJygrt34rB204GGzNOWnTXQIx1BvdYav8HhmxwXz5iBcR8ELI
         KoFuZ+fig6x87SxkgooM4IY2H56PA8zuosVoLv50=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xAFB0BJB099107
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Nov 2019 05:00:12 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 15
 Nov 2019 05:00:11 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 15 Nov 2019 05:00:11 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAFB09ft085879;
        Fri, 15 Nov 2019 05:00:10 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
Subject: pci-usb/pci-sata broken with LPAE config after "reduce use of block
 bounce buffers"
To:     Christoph Hellwig <hch@lst.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Message-ID: <120f7c3e-363d-deb0-a347-782ac869ee0d@ti.com>
Date:   Fri, 15 Nov 2019 16:29:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Christoph,

I think we are encountering a case where the connected PCIe card (like PCIe USB
card) supports 64-bit addressing and the ARM core supports 64-bit addressing
but the PCIe controller in the SoC to which PCIe card is connected supports
only 32-bits.

Here dma APIs can provide an address above the 32 bit region to the PCIe card.
However this will fail when the card tries to access the provided address via
the PCIe controller.

The first commit where we actually start seeing issue is
commit 21e07dba9fb1179148089d611fc9e6e70d1887c3 (j7_serdes_v2)
Author: Christoph Hellwig <hch@lst.de>
Date:   Tue Apr 3 19:09:59 2018 +0200

    scsi: reduce use of block bounce buffers

Can you give hints on how to solve this?

Thanks
Kishon
