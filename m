Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5151C74F8C5
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jul 2023 22:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbjGKUJ3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jul 2023 16:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjGKUJ2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jul 2023 16:09:28 -0400
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4ED51722
        for <linux-pci@vger.kernel.org>; Tue, 11 Jul 2023 13:09:20 -0700 (PDT)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-666ecf9a081so5408247b3a.2
        for <linux-pci@vger.kernel.org>; Tue, 11 Jul 2023 13:09:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689106160; x=1691698160;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lMJwZ8kAMR/naZvtIfWHzEjIasoE6IRJi+ShdVOpKCk=;
        b=B7F1zOor6/5pH9BTZSRyurnqZOhdK2hV5QYmlRvC9o3b1Z+K+O/MEkuDfHYOG9u3c7
         1j7+nDfu0sWHO35gXmEUNYHs8ePzqNBtgXD15iQ9oIfjxixMILLKwwW/rtEbR1cMIMCw
         cqPdT+EhJXces6IQ1lW+Z8m8s4Z5h890R4r4safGG6c8xnGkoCRkG8bAPZOeAx3LS4gj
         PtfDoE8RSA6C2KiCljpl9+6rQLxDONcWBMDvzV0b3JJBbIwOd54wRYaLk7SCSKameAld
         NWnZX/K5rt6XZ/7yiyNDyR7D66EkxlFzQq9FypXqKp5rlyhDq/4WsHXnFG2Sad5oGNeo
         ffbQ==
X-Gm-Message-State: ABy/qLY8lp6rdN54/K+Ocl157+3Tig1xFTuqy9qzEY3OFb4XJhBMPltv
        WCUBLVpVGv+qcpq+CJsX5OHeGlTMz/YH2X2S
X-Google-Smtp-Source: APBJJlEMkDJl43ARcG6lzf4hTkMzpWHfzTW2q9k9uIHW4MAlwmSP3PAeQN5hNVsYSmr1VltJAOV0Hg==
X-Received: by 2002:a17:903:1107:b0:1b8:8af0:416f with SMTP id n7-20020a170903110700b001b88af0416fmr19728245plh.1.1689106159501;
        Tue, 11 Jul 2023 13:09:19 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id f8-20020a170902684800b001b53953f314sm2389605pln.23.2023.07.11.13.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 13:09:18 -0700 (PDT)
Date:   Wed, 12 Jul 2023 05:09:16 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Linux PCI <linux-pci@vger.kernel.org>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?utf-8?B?SsO2cmc=?= Roedel <jroedel@suse.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: The VFIO/IOMMU/PCI MC at LPC 2023 - Call for Papers
Message-ID: <20230711200916.GA699236@rocinante>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello everyone!

Recently, we announced that the VFIO/IOMMU/PCI micro-conference is going to
be part of this year's Linux Plumbers Conference, see:

  https://lore.kernel.org/linux-pci/20230620114325.GA1387614@rocinante

That said, I am thrilled to announce that the Call for Papers (CfP) is open!

If you would like to submit a talk for the MC, please follow the process at
https://lpc.events/event/17/abstracts, selecting "VFIO/IOMMU/PCI MC" from
the available tracks.

The deadline for talk proposal submission is early August, so only a few of
weeks are left!  Remember: you can submit the proposal early and refine it
later; there will be time.  So, don't hesitate!

Again, you can find the complete MC proposal at:

  https://drive.google.com/file/d/1U3_WvPzVeP7DcTSs5FN7jZ2EtTTzUSor

As a reminder: the conference registration is still open, so remember to
reserve your attendance.

Thank you for your help, and see you at the LPC 2023!

	Alex, Bjorn, Jörg, Lorenzo and Krzysztof
