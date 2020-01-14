Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E18913B3D6
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2020 21:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgANUzg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jan 2020 15:55:36 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:33095 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgANUzg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jan 2020 15:55:36 -0500
Received: by mail-yb1-f196.google.com with SMTP id n66so1944274ybg.0
        for <linux-pci@vger.kernel.org>; Tue, 14 Jan 2020 12:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BUYwUy2fDJyl5O/FssXYizN9RZrtlMGcja1+uO0rXSA=;
        b=NEv+cDqSYreP50KlOiF6+PWm8BytNU5kHs9Lkr5uu6HBtRnj5q7NVxlChzeuMmMHw/
         3v0YJ9lPqmdVil4i5JXOSndbMfjo8CnjvoN4+ERv2lhRlU4EZQY24iLiJcWwJtm67b/Q
         TLgSaqqQnsQkNdnwRikSGJaJ6TmGUENtM52XIsTN8B2kjtIwiGuWq6Keuz45H1oC4aCZ
         ctDv0lUAcx16uYj/BmWdy3yLsYBz9seyDxseG5fBCtN6dSUxnsWwogUVpW41rM/9h9xR
         dQ5tCZ9GmfDiO5C5yDg4tigYMdlEH+wZ+m7oOcqVx3zbjyOpR4jolZFIzAAR04geuod0
         eEFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BUYwUy2fDJyl5O/FssXYizN9RZrtlMGcja1+uO0rXSA=;
        b=TmytnI0491su5kzFGNU7kBZAaMKw3s8IdS1tbAxE6sJERxU78VoqPwl+luRT1EJzPH
         ewQ0QxTwx+BHkgL+lO46YplNLJEvxFcwTsadqIn4FqYl95l3aDoVRLq3mNRMo0SI2F/c
         DCZ7sMkE544X7OKALs7RmqsWnUXdQYtoCgM/U+11OuSzByox8e1Fkb45HHnAayrmYDnP
         Rzhs48AlcJ8s9Il9eUhwDMQYZRd4XpYAynoZsfrEGZD+LG+vgUKSQYHch2AzRn7pSL81
         hagVc74cxfnipVxl166sNxCc1iWC00RzaxHHPSNvjdRpPtukB6cSOYGg2wzNAdM3jE5c
         FwJg==
X-Gm-Message-State: APjAAAWQikGw4VBrAMo23+XE4yg4WsQF8cj4QJ/tzR+m2eggn7SBzqEP
        mR2POQ1PlNUBdkuo6YEg8sU=
X-Google-Smtp-Source: APXvYqzrUyqSx8KY0o1U9CC8mTy4P5AWzDm+eAk8T7g7Le2r3qHIWe+VbvZBYl3O/yvTwDMXNJ3eLw==
X-Received: by 2002:a5b:3c9:: with SMTP id t9mr13197020ybp.377.1579035335198;
        Tue, 14 Jan 2020 12:55:35 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
        by smtp.gmail.com with ESMTPSA id a189sm7440521ywh.92.2020.01.14.12.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 12:55:34 -0800 (PST)
From:   Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To:     amd-gfx@lists.freedesktop.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com
Cc:     Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 0/2] Adjust AMD GPU ATS quirks
Date:   Tue, 14 Jan 2020 15:55:21 -0500
Message-Id: <20200114205523.1054271-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We've root caused the issue and clarified the quirk.
This also adds a new quirk for a new GPU.

Alex Deucher (2):
  pci: Clarify ATS quirk
  pci: add ATS quirk for navi14 board (v2)

 drivers/pci/quirks.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

-- 
2.24.1

