Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A14761697
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jul 2023 13:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234975AbjGYLkm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jul 2023 07:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234973AbjGYLkh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jul 2023 07:40:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C2D1BC3
        for <linux-pci@vger.kernel.org>; Tue, 25 Jul 2023 04:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690285186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1je98xYKk91uty9V//ddQUBh34yh1GHtboW9x39SKW8=;
        b=BLY4rdrmturV3YZNrRuah/2kr7ihD1wfuvN9dUIPpfyO3GmJJIZfyrlTh5Kkb35Y+PG7Dy
        8aVVHBsV9uIW7pxTHT2jqEkEZ4dhSshq4gXK/lwfVek83X5BVUFGRRYGKmYR7OjPkOhr5V
        xk6lFDcbhO81yVQcjOpko3UG5GzMFR8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-344-48PiCGnxPxSkVP5K3zccCg-1; Tue, 25 Jul 2023 07:39:41 -0400
X-MC-Unique: 48PiCGnxPxSkVP5K3zccCg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 79EC58065D2;
        Tue, 25 Jul 2023 11:39:41 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 905C24094DC0;
        Tue, 25 Jul 2023 11:39:40 +0000 (UTC)
From:   Igor Mammedov <imammedo@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     terraluna977@gmail.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, imammedo@redhat.com, mst@redhat.com
Subject: [RFC 0/3] acpipcihp: fix kernel crash on 2nd resume
Date:   Tue, 25 Jul 2023 13:39:35 +0200
Message-Id: <20230725113938.2277420-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Changelog:
  * split out debug patch into a separate one with extra printk added
  * fixed inverte bus->self check (probably a reason why it didn't work before)


1/3 debug patch
2/3 offending patch
3/3 potential fix
  
I added more files to trace, add following to kernel CLI
   dyndbg="file drivers/pci/access.c +p; file drivers/pci/hotplug/acpiphp_glue.c +p; file drivers/pci/bus.c +p; file drivers/pci/pci.c +p; file drivers/pci/setup-bus.c +p; file drivers/acpi/bus.c +p" ignore_loglevel

should be applied on top of 
   e8afd0d9fccc PCI: pciehp: Cancel bringup sequence if card is not present

apply a patch one by one and run testcase + capture dmesg after each patch
one shpould endup with 3 dmesg to ananlyse
 1st - old behaviour - no crash
 2nd - crash
 3rd - no crash hopefully

Igor Mammedov (3):
  acpiphp: extra debug hack
  PCI: acpiphp: Reassign resources on bridge if necessary
  acpipcihp: use __pci_bus_assign_resources() if bus doesn't have bridge

 drivers/pci/hotplug/acpiphp_glue.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

-- 
2.39.3

