Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 695903A7BBD
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jun 2021 12:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbhFOK2F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Jun 2021 06:28:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32682 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231288AbhFOK2E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Jun 2021 06:28:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623752760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=h2UOdzryF6sn8L4XRhvrh+Vyxn6lZrCVAYeiITI8oa4=;
        b=PgaG6WQSq9I79t5wA+Vv94ebzAgzsvPZKKltVnLLb9Cat9bAgTWbpqjO8/tWM9CvtioKUT
        GH29RB6YW7/o/lBvyyb5wsKZYP7HJ2g8RmaW+ylarSkaqCjO2wDdPXDG/Mu27drafj8NzH
        ycerf+QcEKpknJyTQSwyqzGRcd5oGgY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-4HptgHMPNGicKJOuvP3D6g-1; Tue, 15 Jun 2021 06:25:58 -0400
X-MC-Unique: 4HptgHMPNGicKJOuvP3D6g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4AA791850618;
        Tue, 15 Jun 2021 10:25:57 +0000 (UTC)
Received: from x1.localdomain (ovpn-113-81.ams2.redhat.com [10.36.113.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0F5EF5D9CA;
        Tue, 15 Jun 2021 10:25:55 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [RFC 0/1] PCI/ACPI: Make acpi_pci_root_validate_resources() reject IOMEM resources which start at address 0
Date:   Tue, 15 Jun 2021 12:25:54 +0200
Message-Id: <20210615102555.6035-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi All,

Here is an attempt to fix an issue which is causing I2C-HID touchpads /
touchscreens to not work on various recent Intel CPU using Lenovo Ideapad
laptop models. There are quite a few reports about this and I think I've
finally figured out what is going on here. See the patch for details.

Note this is just a RFC for now, with as purpose to gather some feedback,
specifically feedback on if the solution I came up with to just reject all
_CSR returned PCI IOMEM regions with a base-address of 0 is acceptable.

This is a RFC becase I'm waiting to hear back from the reporters to see if
the patch actually fixes things.

Regards,

Hans


Hans de Goede (1):
  PCI/ACPI: Make acpi_pci_root_validate_resources() reject IOMEM
    resources which start at address 0

 drivers/acpi/pci_root.c | 7 +++++++
 1 file changed, 7 insertions(+)

-- 
2.31.1

