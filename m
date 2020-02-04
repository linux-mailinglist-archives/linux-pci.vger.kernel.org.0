Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 374781522D6
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2020 00:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgBDXGc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Feb 2020 18:06:32 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52384 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727870AbgBDXGc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Feb 2020 18:06:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580857591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DO/Xi89OctX35qHJWa941zo5bE3USXLm36HQJDjJekY=;
        b=XmE6AmQa87G8jomfjcDsFVZtFYxDTKzMoAR22OJOAcVd4ESyyh7qU2zA4CvlDAi28ZcoUC
        aHnBJ0SkrIp5cO5Ye/Oe9XfvPhTP6UVfA9b57cYqY0MvMKTQszj9Ic3ahxiz+kTtx0ZBje
        VwAEMLG5ysGhnqvjrR/CivIBvtYAWwU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-M2U3FLxXO0eCspnmD1wBtg-1; Tue, 04 Feb 2020 18:06:27 -0500
X-MC-Unique: M2U3FLxXO0eCspnmD1wBtg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6726C184AEA3;
        Tue,  4 Feb 2020 23:06:25 +0000 (UTC)
Received: from gimli.home (ovpn-116-28.phx2.redhat.com [10.3.116.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B5A8A2116;
        Tue,  4 Feb 2020 23:06:24 +0000 (UTC)
Subject: [RFC PATCH 6/7] vfio/pci: Remove dev_fmt definition
From:   Alex Williamson <alex.williamson@redhat.com>
To:     kvm@vger.kernel.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dev@dpdk.org, mtosatti@redhat.com, thomas@monjalon.net,
        bluca@debian.org, jerinjacobk@gmail.com,
        bruce.richardson@intel.com, cohuck@redhat.com
Date:   Tue, 04 Feb 2020 16:06:24 -0700
Message-ID: <158085758432.9445.12129266614127683867.stgit@gimli.home>
In-Reply-To: <158085337582.9445.17682266437583505502.stgit@gimli.home>
References: <158085337582.9445.17682266437583505502.stgit@gimli.home>
User-Agent: StGit/0.19-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

It currently results in messages like:

 "vfio-pci 0000:03:00.0: vfio_pci: ..."

Which is quite a bit redundant.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/vfio/pci/vfio_pci.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 026308aa18b5..343fe38ed06b 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -9,7 +9,6 @@
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-#define dev_fmt pr_fmt
 
 #include <linux/device.h>
 #include <linux/eventfd.h>

