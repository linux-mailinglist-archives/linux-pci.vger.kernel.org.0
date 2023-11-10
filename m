Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96AE17E807B
	for <lists+linux-pci@lfdr.de>; Fri, 10 Nov 2023 19:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344907AbjKJSMX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Nov 2023 13:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345701AbjKJSLT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Nov 2023 13:11:19 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786E32FEF1
        for <linux-pci@vger.kernel.org>; Fri, 10 Nov 2023 03:35:35 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6c4eb5fda3cso213528b3a.2
        for <linux-pci@vger.kernel.org>; Fri, 10 Nov 2023 03:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1699616135; x=1700220935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C1IYhuhVSdfYuyJAuKx2vgmdG+BrUDQ8aS8yHc+1o4A=;
        b=cdTxP94uM2SUNXGilj/OuvA03SGQeWQql2o13biIBoUMWdb7peaUnHUyNzunGn+Zgv
         jIhDWPK1YB5NnILbb9IrRvcUWCk6CQTeeyiFv5DvTPl4YpoRSxIie47473xLwE5eJgDX
         crW5XmsDafGBMe9x2aa5IkNWcHWl+HYV4kBF93dJTHo9lb9QocVuaa6udcSWufaB1iFV
         Cyo8Pll1+OisaP7UHZctODF6IMePriO+8IK2+SQkWpn1YH+UE7kK8bDpM+VgG4Rnfk+n
         8HqYBpGMAqc291pga+vpI6dM/XeWe6E84wbZVmEgLbbXNYCPf+ZktZTkLBVC4XvJImwp
         FU6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699616135; x=1700220935;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C1IYhuhVSdfYuyJAuKx2vgmdG+BrUDQ8aS8yHc+1o4A=;
        b=G1T7o7Z58++Mi8P6UQDSblyBncjvM222GUIeZJ2gb0bpMVRIRQzO91xvzBS1lLmhGu
         E+8g6qjo6FCE0CVxCEk0vNza7sl5CRtw51Ui7H8+zTefHQWW9RiWFsUlRMknMF2yXZT8
         zodzuB3268AMaKeArLWf635iFl7B01L+U1VLn4qBrMENd4L7rcgxtdCVHETj1VeGbuqf
         tElH2wJw0QopV2CIyQHphVdWHWSvhFVkRNV98pbI/MyO7QbBfCx7ltjXJ5UCuStBv5IT
         +NOz5bGRNgR9xckGBJGWZ6MHx+kHwaSPqWhQgUm0R2qdLZaWYLhG5MNpBzR/dH1O+wre
         lTFg==
X-Gm-Message-State: AOJu0YyHMBLKzUAu6JMBGCT1o5VHf4nr+/HEqjkp2rrqEKPiggRpYjeJ
        4dmcwV5sheSiHOnA+n+AyjzUY7NL9Dj+oR7LY8l6qg==
X-Google-Smtp-Source: AGHT+IGQ2WpJqljcLWnVsfgBmOLpEtUYUsX5fxP4jNAbTYVQyoUgWXdMZaF8tVwHrVKLl6Xc9zfPew==
X-Received: by 2002:a05:6a00:888:b0:6be:319:446b with SMTP id q8-20020a056a00088800b006be0319446bmr9246458pfj.21.1699616134765;
        Fri, 10 Nov 2023 03:35:34 -0800 (PST)
Received: from dns-msemi-midplane-0.sjc.aristanetworks.com ([74.123.28.12])
        by smtp.gmail.com with ESMTPSA id z16-20020aa78890000000b006bdd7cbcf98sm12309574pfe.182.2023.11.10.03.35.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Nov 2023 03:35:34 -0800 (PST)
From:   Daniel Stodden <dns@arista.com>
To:     Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deo2ltatee.com>,
        linux-pci@vger.kernel.org
Cc:     Daniel Stodden <dns@arista.com>
Subject: [PATCH 0/1] switchtec: Fix stdev_release crash after suprise device loss.
Date:   Fri, 10 Nov 2023 03:35:11 -0800
Message-ID: <20231110113512.83254-1-dns@arista.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello.

Here goes a small shell script to crash a kernel in switchtec.ko's
stdev_release.

--snip--
#!/bin/bash -x
# open cdev
exec 3<>/dev/switchtec0
# remove pdev
addr=$(basename $(realpath /sys/class/switchtec/switchtec0/../..))
echo 1 > /sys/bus/pci/devices/$addr/remove
# close cdev
exec 3>&-
--snip--

It worked on v5.10. I believe it has been working ever since. The
problem is that keeping the stdev pinned past the pci_driver removal
will defer the mrpc dma shutdown until way after devres_release_all,
which unmapped stdev->mmio_mrpc. Also, stdev->pdev would be a stale
pointer by then.

Followed-up with a humble proposal how to fix it.

Thanks,
Daniel

Daniel Stodden (1):
  switchtec: Fix stdev_release crash after suprise device loss.

 drivers/pci/switch/switchtec.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

-- 
2.41.0

