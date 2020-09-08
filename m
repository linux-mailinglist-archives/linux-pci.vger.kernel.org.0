Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6722620AE
	for <lists+linux-pci@lfdr.de>; Tue,  8 Sep 2020 22:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730920AbgIHUNU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Sep 2020 16:13:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39622 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729655AbgIHPLL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Sep 2020 11:11:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599577821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=c0M6COgSMY8XpsNV/nWmLLPGL6MF5yyY/WPDfg1karI=;
        b=PTkuXwNz/Cv0HhPLk8kejuJp7t5c2qafsizlMoDd3B/wwTzSy07/Cek9GT5k1gDhDJdc+Q
        ZnUNH8WTvWo9rJLXCJElE8qHs2SknRIKU6P7hDI8nq7FTUpdXPZHPCbM1oAhwnSlERF4jg
        nkswHuRoK2CqD72MPb/fzdhh5iXm/xs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-0AknQ2QPOe2n8Y07RHLKbw-1; Tue, 08 Sep 2020 10:57:29 -0400
X-MC-Unique: 0AknQ2QPOe2n8Y07RHLKbw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 116F71DDEF;
        Tue,  8 Sep 2020 14:57:28 +0000 (UTC)
Received: from zim (ovpn-112-96.phx2.redhat.com [10.3.112.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F90C5C230;
        Tue,  8 Sep 2020 14:57:27 +0000 (UTC)
Date:   Tue, 8 Sep 2020 08:57:26 -0600
From:   Myron Stowe <mstowe@redhat.com>
To:     linux-pci@vger.kernel.org
Cc:     bhelgaas@google.com, lukas@wunner.de, klimov.linux@gmail.com
Subject: PCIe hot-plug issue: Failed to check link status
Message-ID: <20200908085726.54509090@zim>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On a system with a Mellanox Technologies MT27800 Family [ConnectX-5]
NIC controller containing a power button, hot-plug fails to function
properly.

  Normal, expected, scenario:
    o Press the OCP NIC's power button;
    o Power button LED blinks and turns off (delivering event message
      to CPU);
    o Verify NIC is offline via 'lspci';
    o Remove controller.

  Scenario with cmdline parameter 'pcie_port_pm=off':
    o Press NIC's power button;
    o LED turns off;
    o Verify NIC is offline;
    o Press power button (in an attempt to hot-add controller);
    o NIC is not recognized.

  Scenario with no cmdline parameter, or ''pcie_aspm=off', or
  'pcie_aspm=off pcie_port_pm=off':
    o Press NIC's power button;
    o LED continuously flashes;
    o Checking via 'lspci' indicates NIC is offline but with LED
      flashing, the controller can not be removed.

The 'dmesg', and 'lspci', logs are included within the
associated bugzilla:
  https://bugzilla.kernel.org/show_bug.cgi?id=209113


As stated in the bugzilla, I'm relaying all this information second
hand.  Hoping to get the affected party involved directly.

