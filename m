Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 909F51C3286
	for <lists+linux-pci@lfdr.de>; Mon,  4 May 2020 08:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgEDGSD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 May 2020 02:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgEDGSD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 May 2020 02:18:03 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEAAC061A0E
        for <linux-pci@vger.kernel.org>; Sun,  3 May 2020 23:18:02 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id x25so7053134wmc.0
        for <linux-pci@vger.kernel.org>; Sun, 03 May 2020 23:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/QPEOCYA02sDCotUfQPVcojJzssWpbusVJYfCsRI7SU=;
        b=VHhosTF+HtEGQT9ISgoyeUqtFqOFEg5HYWONE+W33OxEUp9bK+FgSkQXKphqX+WQP1
         0sHZZuY+0EOAUnzLhhFL1WTof501b/xHLsnAVtQeBTmwUbPqtX+tRSg601zh9yQRCVEL
         24GjGocpa6qmXg9lM7bbXiJLAPm2xs4/SPGbpPoPs8HOePiFxgu7erZhUoAf7SXfFAa1
         OOkd3ZgU6Oe71aEmTzYrsijRzJfLo4/6Vo35SgFNHH/dkXqyBVsNgsPPEv19sZGNGLdQ
         hSTJe8t8QV51L7yEyZVDEP8AtNspWaYof98oym+ftCOuWbhYiOcuj7Sd4vim+FKNsWV2
         W6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/QPEOCYA02sDCotUfQPVcojJzssWpbusVJYfCsRI7SU=;
        b=TcU1jL8npgLSFGNt259efCiNVPLUUauaJfXA3sowEYJN0KSN8zRNuIaCy8vPjj+rZF
         5TZAGWhbGAUFWYW8NZjB9yhDlN0u3TuVTN1IOrL1ug3qvO8HbEcA9yRfiCqLfsLWJvbe
         anBrlNyHIKtAkJlAGW1m1nw9B07yHwJsdXEjfBzASw2YberjLHPyQLkmgawOMLSSKNfS
         yd5uMKBAqSHpYQQwl3x/NFX0e16k3KjkImU7rNYzLV27e1R6ryaKiPKIUEAatAChC4Dx
         EgE0I5Cv5z1BQyITeCdjD5/uRxPVXzECeswNS2C1tl50Swi1KvA5AA/LOPl/lckYjAUW
         fn9Q==
X-Gm-Message-State: AGi0PuZ3pmO7CIJbxv/M3+8xw5Dc9LfC98CUyLd608HSEqVA3g1+ai/S
        7eR5WcEfQRcA3FLDBSPIA3k=
X-Google-Smtp-Source: APiQypJeiJs5qQUYJ8ms6IPR5I2EsBQJ5NDAFItX40I2/3jPNGY/MVRiGGqzoXmzCtR4p+y/up0kHw==
X-Received: by 2002:a1c:2002:: with SMTP id g2mr12301205wmg.109.1588573081503;
        Sun, 03 May 2020 23:18:01 -0700 (PDT)
Received: from net.saheed (540018A9.dsl.pool.telekom.hu. [84.0.24.169])
        by smtp.gmail.com with ESMTPSA id k23sm11559004wmi.46.2020.05.03.23.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2020 23:18:00 -0700 (PDT)
From:   refactormyself@gmail.com
To:     helgaas@kernel.org
Cc:     Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
        bjorn@helgaas.com, yangyicong@hisilicon.com,
        skhan@linuxfoundation.org, linux-pci@vger.kernel.org
Subject: [PATCH RFC 0/2] pci: Make return value of pcie_capability_*() consistent
Date:   Mon,  4 May 2020 07:18:10 +0200
Message-Id: <20200504051812.22662-1-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>

Changes in version 5:
 - Extend consitency to all accesors, they all now return PCIBIOS_* error
   codes
 - Enforce -ve error code, any case of > 0 error code is return as -ERANGE
   this is done in line with the implementation of pcibios_err_to_errno()
   which is now deprecated.
 - Set all PCIBIOS_* error codes to generic error codes.
 - pcibios_err_to_errno() is now dormant and deprecated. It will return
   -ERANGE if a any positive error code is passed into it.
 - Remove verbose dependency audit report from commit log. No conflict was
   discovered so far.

Changes in version 4:
 - make patch independent of earlier versions
 - add commit log
 - add justificaation and report on audit of affected functions

Bolarinwa Olayemi Saheed (2):
  pci: Make return value of pcie_capability_{read|write}_*() consistent
  Set all PCIBIOS_* error codes to generic error codes

 drivers/pci/access.c | 64 +++++++++++++++++++++++++++++++++++---------
 include/linux/pci.h  | 31 +++++++++++----------
 2 files changed, 66 insertions(+), 29 deletions(-)

-- 
2.18.2

