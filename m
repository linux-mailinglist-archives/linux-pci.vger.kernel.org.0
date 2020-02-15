Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3B2715FBCA
	for <lists+linux-pci@lfdr.de>; Sat, 15 Feb 2020 01:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbgBOAyu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Feb 2020 19:54:50 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41856 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgBOAyu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Feb 2020 19:54:50 -0500
Received: by mail-pl1-f196.google.com with SMTP id t14so4335106plr.8
        for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2020 16:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t/Ae0ThnHgseaBLN7DLSea9YhAAyHLCHWTCUQ/Cd0kU=;
        b=dmb7qpA2kFDG/NeGqhlDaCtOJWwEN5yo+psjRdIA/bxIrzPR3KzcxIxfolRXzD6CcP
         2NC+PI/DxfYxt7rXTp8/PiZ1MGGbum2c4Kl5D03YD277KB61qw7nslgxLzjHjKHBhKcJ
         ZBsP0TljWgjefXI4xv3hkW+INuat00Dau0n8hyhSxpcHMPfWtp7ZgyCYqZznVJEEPtqG
         x+frDrsbZR9CKGFdbltKjXzek8iwS8kZGV0rJTshxAsX08Yr5lmS6KgA35GMs+Cr9XxZ
         OcaIJR0FTgSD16qySdGsQZIsrqWu058/ATIayvioSzsnYxp88B8ZMpiMzmRZiqdOQb83
         d02w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t/Ae0ThnHgseaBLN7DLSea9YhAAyHLCHWTCUQ/Cd0kU=;
        b=fFai8LYHA8vAGyR4kVwXhOgmYj3Mf8xFwkj6+i5v5s4u/BQx7yi4VHp9nfgjPZhrE/
         coLurdotqBqLHrTTuL1Bmfm4kS13VlilNWFyvbC6XKgGue9MI60pNjzp63ZN+y+ZQf1T
         Qn8dZN6a3T6cT98tNaWum8OhVMW8m3cpfNAnrBxK/dC5kqKk/1XbYUcj4IhMPH9YgsC9
         +IDZ0Oq+1YsQTm9kARAGJ1sIe2qZx+mIlWw8uozRsGY5hcJeG8MQft2gXv8ZXr7WMYSP
         JXZs/P9SxcGN7kEz5w9IiECDJ4yNyPF5dzJN6DCeIP7eUOONi3m0cYA33Crg+L11vs8q
         fJvQ==
X-Gm-Message-State: APjAAAXYFBA5dE2BLespuXK62VH9VV8xn1+p/0f1sKDcXOXgKv+Zih3c
        ULJxsLKsPOx9iS1dU8ZEmNxTkWEBBao=
X-Google-Smtp-Source: APXvYqyjZLi/e9QST8sioy2HdXygGOdJ9mbIInRhBVQPczjn+5/OJPK4T7vMHeDuqoNVw8iYHt85OA==
X-Received: by 2002:a17:902:bb88:: with SMTP id m8mr5848515pls.63.1581728088542;
        Fri, 14 Feb 2020 16:54:48 -0800 (PST)
Received: from nuc7.sifive.com ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id b25sm8108857pfo.38.2020.02.14.16.54.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Feb 2020 16:54:47 -0800 (PST)
From:   Alan Mikhak <alan.mikhak@sifive.com>
X-Google-Original-From: Alan Mikhak < alan.mikhak@sifive.com >
To:     ard.biesheuvel@linaro.org
Cc:     Joao.Pinto@synopsys.com, bhelgaas@google.com,
        graeme.gregory@linaro.org, jingoohan1@gmail.com,
        leif.lindholm@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, marc.zyngier@arm.com
Subject: [PATCH 2/3] pci: designware: add separate driver for the MSI part of the RC
Date:   Fri, 14 Feb 2020 16:54:25 -0800
Message-Id: <1581728065-5862-1-git-send-email-alan.mikhak@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20170821192907.8695-3-ard.biesheuvel@linaro.org>
References: <20170821192907.8695-3-ard.biesheuvel@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi..

What is the right approach for adding MSI support for the generic
Linux PCI host driver?

I came across this patch which seems to address a similar
situation. It seems to have been dropped in v3 of the patchset
with the explanation "drop MSI patch [for now], since it
turns out we may not need it".

[PATCH 2/3] pci: designware: add separate driver for the MSI part of the RC
https://lore.kernel.org/linux-pci/20170821192907.8695-3-ard.biesheuvel@linaro.org/

[PATCH v2 2/3] pci: designware: add separate driver for the MSI part of the RC
https://lore.kernel.org/linux-pci/20170824184321.19432-3-ard.biesheuvel@linaro.org/

[PATCH v3 0/2] pci: add support for firmware initialized designware RCs
https://lore.kernel.org/linux-pci/20170828180437.2646-1-ard.biesheuvel@linaro.org/


Regards,
Alan Mikhak
