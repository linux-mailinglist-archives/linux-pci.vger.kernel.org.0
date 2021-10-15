Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04D1B42F7AE
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 18:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241113AbhJOQIv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 12:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241059AbhJOQIu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Oct 2021 12:08:50 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D827C061570
        for <linux-pci@vger.kernel.org>; Fri, 15 Oct 2021 09:06:44 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id p6-20020a9d7446000000b0054e6bb223f3so13491765otk.3
        for <linux-pci@vger.kernel.org>; Fri, 15 Oct 2021 09:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=I1hD65KZvsTUM11Z3+OFqcCldJ1PmlO0xyX0FqNo4g8=;
        b=l7XGJBtJWwSkDWFWzBueb4AOSdvZPd4CkJ2gDdb73FyZEMtgbjYfBINLTJu83ai4hT
         tajsKA8RLPGARMVv0m/Q1I3VOGvUPGjRJNixb/okrR20oTnyWPoGjITcAkKW4pG6s0q/
         zPtHNRSkFDmgBhGlFxfmcOb90crdFxjQ4/xmXZZFiZ2uu9VqpLYi7IXAl8BMc3OPwLHG
         TuwbXZENdhyAH6g2S2+XB9LvSLEkU/wWI02BHGXAzGL7/f9JJlnbl3EryOw1tMojjc2n
         G4LTqIpMCJ4CkTmBgcEMz16PS0TqEPdW5Z/2HDJTb1fdjgWQh1++6o2ABzCWEfNVmmqV
         YcCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=I1hD65KZvsTUM11Z3+OFqcCldJ1PmlO0xyX0FqNo4g8=;
        b=rRSsPkflZorqRtsrVyxb3ZKNET6rEF7hHHG7QZdHJoMgpduWORHw/NFQ1nagZgQjXU
         7qLA3R2muESvLli4PCq5pz1C+9t5zX7hFcpHQD2+HOl/WblMy8YdHwsoW3MA0uUNq1Xk
         etQMlpip4ii6hKJCnFQnqXXtSagEyQDj9vAq53e8l7p9Y6cSLnYW+/Dv/7K0qP5sUf0R
         gQ7CRhFV6Ju0LRj23H+63/URVPWkwAYFzv8lLBe6uHzxooCjokg0Nn5rME27lVk0seBv
         MDFmC8njY7CaocpsbgoeorQp741GxOxvv8kzs7X1opRloDM93o5vwcAjdK6o3ooBNWfk
         VDNg==
X-Gm-Message-State: AOAM533sPV140F3T95Ku59mOGGr5yDmUdoSpA5qpa19Ht4kvCf1yxgRc
        ml2vriRk5PAbDSlTErs2oscNi2W2oaJSCfs/+uKD3OVcY9THxg==
X-Google-Smtp-Source: ABdhPJw6yX5L5dezK5z0mmUW9dbMl86S6pg5jOzb/va4JUt41Rwc0U5zQOe0QKe2HobyCq8dSYvnArBjCiA5B7smi5w=
X-Received: by 2002:a05:6830:3148:: with SMTP id c8mr5714344ots.351.1634314003564;
 Fri, 15 Oct 2021 09:06:43 -0700 (PDT)
MIME-Version: 1.0
From:   Ajay Garg <ajaygargnsit@gmail.com>
Date:   Fri, 15 Oct 2021 21:36:31 +0530
Message-ID: <CAHP4M8URVjPEGFLHFXk4iS-7FYpg_=ZCVr2f6ufcFkNnZqAUug@mail.gmail.com>
Subject: Host-PCI-Device mapping
To:     QEMU Developers <qemu-devel@nongnu.org>,
        iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello everyone.

I have a x86_64 L1 guest, running on a x86_64 host, with a
host-pci-device attached to the guest.
The host runs with IOMMU enabled, and passthrough enabled.

Following are the addresses of the bar0-region of the pci-device, as
per the output of lspci -v :

* On host (hpa) => e2c20000
* On guest (gpa) => fc078000


Now, if /proc/<qemu-pid>/maps is dumped on the host, following line of
interest is seen :

#############################################################################
7f0b5c5f4000-7f0b5c5f5000 rw-s e2c20000 00:0e 13653
  anon_inode:[vfio-device]
#############################################################################

Above indicates that the hva for the pci-device starts from 0x7f0b5c5f4000.


Also, upon attaching gdb to the qemu process, and using a slightly
modified qemugdb/mtree.py (that prints only the information for
0000:0a:00.0 name) to dump the memory-regions, following is obtained :

#############################################################################
(gdb) source qemu-gdb.py
(gdb) qemu mtree
    00000000fc078000-00000000fc07c095 0000:0a:00.0 base BAR 0 (I/O) (@
0x56540d8c8da0)
      00000000fc078000-00000000fc07c095 0000:0a:00.0 BAR 0 (I/O) (@
0x56540d8c76b0)
        00000000fc078000-00000000fc07c095 0000:0a:00.0 BAR 0 mmaps[0]
(I/O) (@ 0x56540d8c7c30)
(gdb)
#############################################################################

Above indicates that the hva for the pci-device starts from 0x56540d8c7c30.

As seen, there is a discrepancy in the two results.


What am I missing?
Looking for pointers, will be grateful.


Thanks and Regards,
Ajay
