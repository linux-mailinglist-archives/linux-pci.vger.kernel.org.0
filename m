Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FF67271DE
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jun 2023 00:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjFGWlK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Jun 2023 18:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbjFGWlJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Jun 2023 18:41:09 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EC91988;
        Wed,  7 Jun 2023 15:41:04 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b24eba185cso6943285ad.2;
        Wed, 07 Jun 2023 15:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686177663; x=1688769663;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EIF33hiMWS7/Vu/beuu7qZKGgIlJuBg/HJHP1JWkTXM=;
        b=LIMMLb444SdimuyODXevX8HrxRcSUBeezgVcKskNlBnmkRy5xNf3Rt8kJgBtJrpqr+
         3EoWw1d6voer+zr3GHZIXOzgTmITh+65zJKRBYjQIuOWXMHvH9I6HVQx2wnXV/WpS36P
         p620u4LE0W6nnw2dGXdBan2NP+ypDvQ1Kpl4rCd98DmI+D86ikq1P4gLDu0c66gYNFM+
         VPWj7dnHPDxEO2IGl5vcmmE4HShx6uTpZfaoy4dt7YWcbWhiulzTUIQwUph5ABOX4Nz3
         RzMi0A6zxR0eNh7hBE5dBEZb3EuNR9JqpkI/0fnwkdDJ8m/RZdXTPxyYNH2EAMfOh1iZ
         I8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686177663; x=1688769663;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EIF33hiMWS7/Vu/beuu7qZKGgIlJuBg/HJHP1JWkTXM=;
        b=Kz2fsPcLVTqmx1Z4I+8bHyREjkS9Bvy2419r1ChEqiG4G3LvRc2E6lHEkg9tkAkKuc
         qlqrP4p0erqTMflhpcb4osqllxGLutGuj8K4VkWOReuKMxMopXBwhwE8Yc2QuWSKky4g
         TRiDbvLeWCdt9NaITLy/4nTjJ3FBly+qv5zIaWRF+aG0jLndA7ckESPFG4HwtjkAwhPY
         lDcJlX21sEcnzAL0H9ttSxMgiWP2X1tN4Cre0EdasLxGmdrgpSOji5dQM78lIQgoZLBT
         HAjNL18dp+avjwJs8hTXDQyBkbbnnlyYFo4xgPmSBPEyr/ToBfnhBvPN0SIWHvzuPYcB
         xkrQ==
X-Gm-Message-State: AC+VfDy5vwoPzQtf5fx0xsGz2OlOUainuIwdFZyaJM1UlUcIWWzWnr01
        6fYhfNDEl4zTXXDDADcUMYCyEclwlFvZ5al0q4MCBd1CT+s=
X-Google-Smtp-Source: ACHHUZ4IrblhBhvZ0moOdjOb2WF7sR6JEjy8GsXoRmgolzjjz7KVMkrWzdUI7T7v03sMhq1RTkU0D84lV5z2Bb4zvN8=
X-Received: by 2002:a17:903:228d:b0:1b2:4ece:55f1 with SMTP id
 b13-20020a170903228d00b001b24ece55f1mr2010932plh.35.1686177663105; Wed, 07
 Jun 2023 15:41:03 -0700 (PDT)
MIME-Version: 1.0
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Wed, 7 Jun 2023 15:40:26 -0700
Message-ID: <CAKgT0UezciLjHacOx372+v8MZkDf22D5Thn82n-07xxKy_0FTQ@mail.gmail.com>
Subject: Question about reserved_regions w/ Intel IOMMU
To:     LKML <linux-kernel@vger.kernel.org>,
        "open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I am running into a DMA issue that appears to be a conflict between
ACS and IOMMU. As per the documentation I can find, the IOMMU is
supposed to create reserved regions for MSI and the memory window
behind the root port. However looking at reserved_regions I am not
seeing that. I only see the reservation for the MSI.

So for example with an enabled NIC and iommu enabled w/o passthru I am seeing:
# cat /sys/bus/pci/devices/0000\:83\:00.0/iommu_group/reserved_regions
0x00000000fee00000 0x00000000feefffff msi

Shouldn't there also be a memory window for the region behind the root
port to prevent any possible peer-to-peer access?
