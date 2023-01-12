Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB1A56687AE
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jan 2023 00:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbjALXAX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Jan 2023 18:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232647AbjALXAW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Jan 2023 18:00:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D5852C49
        for <linux-pci@vger.kernel.org>; Thu, 12 Jan 2023 15:00:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA92C62181
        for <linux-pci@vger.kernel.org>; Thu, 12 Jan 2023 23:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07067C433D2;
        Thu, 12 Jan 2023 23:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673564420;
        bh=DLo5NJS1HgiJ9JJ9cVXzXouTi2SSZ8s+MnMpOc36hHA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ByewWtaBIrwp2XbPJjlc1PkvGIpsD7KlCkqYkvUHhWLx4tFXe+MuQnxuvfIaOuZto
         WCXZVXIHuPbOid4EYt69QgRnp7EcIBDPbUY3dnXtZ/BkUoPI67CDqPCkibfeleDGxi
         ZDwCCmldBhC3Z3ltlUW8XM/MBBZ2WprpddS3iz7QFQ9cdIBHoJbmxCa5jvSInHhExe
         13m5VxhE7sPDC7ix3zHOknxF6sFI5Upcj1Rcuqr6ygLYBxRDK9JTq8WbZ/MzbVCz1F
         cJuZeCmkKUyBPU67/ic0gF/Aj7bOVZ2G0TtVDhyv+m1EJPJpWcpVYnATBL5sCRWCW8
         o4R5C7vWI8BOw==
Date:   Thu, 12 Jan 2023 17:00:18 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Alexey V. Vissarionov" <gremlin@altlinux.org>
Cc:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jesse Barnes <jbarnes@virtuousgeek.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yu Zhao <yu.zhao@intel.com>, linux-pci@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH] PCI/IOV: "virtfn4294967295\0" requires 17 bytes
Message-ID: <20230112230018.GA1800747@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221218122139.GA1182@altlinux.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Dec 18, 2022 at 03:21:39PM +0300, Alexey V. Vissarionov wrote:
> On 2022-12-18 19:57:02 +0900, Krzysztof Wilczyński wrote:
> 
>  > Thank you for sending the patch over! However, if possible,
>  > can you send it as plain text without any multi-part MIME
>  > involved?
> 
> ACK.
> 
>  > If possible, it would be nice to mention that this needed
>  > to make sure that there is enough space to correctly
>  > NULL-terminate the ID string.
> 
> ACK.
> 
> So, here goes the corrected text:
> 
> Although unlikely, the 'id' value may be as big as 4294967295
> (uint32_max) and "virtfn4294967295\0" would require 17 bytes
> instead of 16 to make sure that buffer has enough space to
> properly NULL-terminate the ID string.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: dd7cc44d0 ("PCI: add SR-IOV API for Physical Function driver")
> Signed-off-by: Alexey V. Vissarionov <gremlin@altlinux.org>

I collected this up and applied to pci/iov for v6.3 as below.  I agree
this is probably only a theoretical issue, but it's easier to spend a
byte of stack space than to prove that we don't need to.

Bjorn


commit 58d4c63d0a27 ("PCI/IOV: Enlarge virtfn sysfs name buffer")
parent 1b929c02afd3
Author: Alexey V. Vissarionov <gremlin@altlinux.org>
Date:   Sun Dec 18 06:33:47 2022 +0300

    PCI/IOV: Enlarge virtfn sysfs name buffer
    
    The sysfs link name "virtfn%u" constructed by pci_iov_sysfs_link() requires
    17 bytes to contain the longest possible string.  Increase VIRTFN_ID_LEN to
    accommodate that.
    
    Found by Linux Verification Center (linuxtesting.org) with SVACE.
    
    [bhelgaas: commit log, comment at #define]
    Fixes: dd7cc44d0 ("PCI: add SR-IOV API for Physical Function driver")
    Link: https://lore.kernel.org/r/20221218033347.23743-1-gremlin@altlinux.org
    Signed-off-by: Alexey V. Vissarionov <gremlin@altlinux.org>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 952217572113..b2e8322755c1 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -14,7 +14,7 @@
 #include <linux/delay.h>
 #include "pci.h"
 
-#define VIRTFN_ID_LEN	16
+#define VIRTFN_ID_LEN	17	/* "virtfn%u\0" for 2^32 - 1 */
 
 int pci_iov_virtfn_bus(struct pci_dev *dev, int vf_id)
 {
