Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67646785773
	for <lists+linux-pci@lfdr.de>; Wed, 23 Aug 2023 14:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbjHWME7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Aug 2023 08:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234771AbjHWMEn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2023 08:04:43 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C25B1990;
        Wed, 23 Aug 2023 05:04:13 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RW4d36fb2z4wy7;
        Wed, 23 Aug 2023 22:04:07 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linuxppc-dev <linuxppc-dev@ozlabs.org>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>
Cc:     Tyrel Datwyler <tyreld@linux.ibm.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <169235811556.193557.1023625262204809514.stgit@jupiter>
References: <169235811556.193557.1023625262204809514.stgit@jupiter>
Subject: Re: [PATCH v9 1/2] powerpc/rtas: export rtas_error_rc() for reuse.
Message-Id: <169279175579.797584.15043748481336876672.b4-ty@ellerman.id.au>
Date:   Wed, 23 Aug 2023 21:55:55 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 18 Aug 2023 16:59:07 +0530, Mahesh Salgaonkar wrote:
> Also, #define descriptive names for common rtas return codes and use it
> instead of numeric values.
> 
> 

Applied to powerpc/next.

[1/2] powerpc/rtas: export rtas_error_rc() for reuse.
      https://git.kernel.org/powerpc/c/e160bf64e2d3df7bf83ed41d09390a32490be6c5
[2/2] PCI: rpaphp: Error out on busy status from get-sensor-state
      https://git.kernel.org/powerpc/c/77583f77ed9b1452ac62caebf09b2206da10bbf9

cheers
