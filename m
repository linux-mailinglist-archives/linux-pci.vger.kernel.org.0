Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 725B928B5F
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2019 22:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387585AbfEWUOo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 May 2019 16:14:44 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:46624 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387513AbfEWUOo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 May 2019 16:14:44 -0400
Received: by mail-pg1-f180.google.com with SMTP id o11so3505754pgm.13
        for <linux-pci@vger.kernel.org>; Thu, 23 May 2019 13:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=tZPNt+rLtUBdYZbp+GReAQDN4uohyDhwin9i7fqNR7M=;
        b=UyRxKupvpchv4zUcVTIPwRGpdH+S9gd/1KPfrt85pLEA2muykirPLiTshBFtrZPhpX
         ZNqkJL0sw3Zg6Df5LaOGlwVR64QpchLLcWy/qn+Hx7jyD2lLM13cmRMVzWBrSn1r4Xls
         W1+OlWofLQN3kwd2SlvoKBPOctI5eKRDkyP/zfCR/N64ApQ7yg9jy26CSLtpHGlyVzpv
         oVx0FLxaqMayfkEXnCfNU+h0+QGWjAGFNnN6Mxpm+uiG8fhwLVrdQHDd6wtUmp6ef5Iq
         XGMmnQGmqD9/uut2xzqjkWdYco4zsLgA66rogAMuNCKB3JlYWt/yVT8qnmYJgh9+PNEh
         I0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tZPNt+rLtUBdYZbp+GReAQDN4uohyDhwin9i7fqNR7M=;
        b=URpOnISdqpVLH0kwKH/I1qevms9FQtX0qdpSA82bGd0HZ1A0xjlVkAwK2+QOqMxd1p
         zfrrv62ytAHNvWn0tvGVB4p3idEeW4VpZ1u1/YsuXMN7tjZIfwU/kuRUqlK3zHXWmLFz
         jFc2ew/HPpobH/lgzIj40NifOHNUYWbo90mDzSsYPBZK2V8tmgUh48Z1YUzdT9qs5vjG
         s+NqLUG4rruK3H1X2kkVlpcaZq5HRqmN5fYUN370xp3rBmT8Ri+qm5WmkMRXaNZ7ZfjM
         u4SKcmlXu54yiSaFOCUYziF1JbjepWAIS4ltnZOkiJ6iTIxhKKljp5gP4+JHU/DiDUu3
         jsCg==
X-Gm-Message-State: APjAAAXSjS7KRhCA+l6EGdNs7dHcR0eOgeI9aCp6ryITWHuAFiwDHtca
        sDsWrWVePRdaWIehfznly94uB+C/i8o=
X-Google-Smtp-Source: APXvYqxdEMuHsSvTD33i4R7P8PwKnLNgtSRQ3qW5XaTRqxwwtBXhqKfM5bY739i1ywptuOGdBFXUgA==
X-Received: by 2002:a63:1820:: with SMTP id y32mr98313150pgl.287.1558642483635;
        Thu, 23 May 2019 13:14:43 -0700 (PDT)
Received: from nuc7.sifive.com ([12.206.222.2])
        by smtp.gmail.com with ESMTPSA id i12sm180839pgb.61.2019.05.23.13.14.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 May 2019 13:14:42 -0700 (PDT)
From:   Alan Mikhak <alan.mikhak@sifive.com>
X-Google-Original-From: Alan Mikhak < alan.mikhak@sifive.com >
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kishon@ti.com, lorenzo.pieralisi@arm.com,
        linux-riscv@lists.infradead.org, palmer@sifive.com,
        paul.walmsley@sifive.com
Cc:     Alan Mikhak <alan.mikhak@sifive.com>
Subject: [PATCH 0/2] tools: PCI: Fix broken pcitest compilation
Date:   Thu, 23 May 2019 13:14:22 -0700
Message-Id: <1558642464-9946-1-git-send-email-alan.mikhak@sifive.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Alan Mikhak <alan.mikhak@sifive.com>

This patchset fixes a compiler error and two warnings that resulted in a
broken compilation of pcitest.

 tools/pci/pcitest.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.7.4

