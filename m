Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF7039FFAC
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 12:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfH1KXZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Aug 2019 06:23:25 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43372 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbfH1KXZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Aug 2019 06:23:25 -0400
Received: by mail-wr1-f66.google.com with SMTP id y8so1901576wrn.10;
        Wed, 28 Aug 2019 03:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:message-id:in-reply-to:references
         :mime-version;
        bh=wyK/ROTq5hiGEtLsw4uZv9FHdnrdKjorIZI4r+cqjPc=;
        b=Q+m7x1iHtQql3U5uyeXAsQMVp8PY+Wbb5pv1ssAxM1eeXIemKTN5oLIPRLWD2bS04l
         iABhqmHvoSKsgEk3DQcr9zNNSLUhxqP14Kn40rd1mubFLE5y76Fnm3s8AryKR1Llr9RH
         C2KmoukTjEOext3LNTg8shT5Lw8Jcnp1aGdas6pKu1kDeQzwAJehDjXVl2URwujnD5Og
         e05okmNUDD6gdQiJL0+sNYvDYSTLmuw/IxPfp6MVoRQmektDxlHwki8R1zKJehzHa2vR
         HdAfHp3rJREoBuSJ3MGGOcH8NJ8Vlq3K7zAOrTIKo0GePoZ9inc+c4BuYqIi2eqOBniN
         oNaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:message-id:in-reply-to
         :references:mime-version;
        bh=wyK/ROTq5hiGEtLsw4uZv9FHdnrdKjorIZI4r+cqjPc=;
        b=FcnasHLhv115dsPtNVND6aVUnv/2eW1w9+U3mZ9ew6JZc6WZUNq0d7Y10KEHVMrDvd
         7MNzI029Bvi/4xSeF3tKFfFkuF91A5dNGtovY20Pzq1DRs3AuRkfKudKPYLj1MDBqEGD
         +YXqI8n2/ma/3DuPrgQuNjp/BfYQgxIaNQlE6LHOmmDSelnaMdV/3haOO6I+dvdWXM6R
         hFbdnpclT+H+/YOdOKIPi3YkMq77uBHp2n83sreMLTojxUKmQMld5og/t8nR+Am2D+bC
         fkl7x3JY+OFqNfxU0TNKelLCTlz39yppjrjByJQ64uQpBNksaSk9cKrMb83jpoa8r+HK
         omGQ==
X-Gm-Message-State: APjAAAXpFNGgeT+rGGSfATdAymR811q/0p13yhhHsocIs/ao0ITZdc0c
        dyEGan1LN3p5VPC9qbedgOI=
X-Google-Smtp-Source: APXvYqx8NQ9jqeZ/HdIwUelTb2YC7sOIaSVHF9TPrp9J+/6sFS8endSgxj5pTGcV6IM+d4scRgIunQ==
X-Received: by 2002:adf:ce08:: with SMTP id p8mr1070588wrn.161.1566987802533;
        Wed, 28 Aug 2019 03:23:22 -0700 (PDT)
Received: from [192.168.1.105] (ip5b4096c3.dynamic.kabel-deutschland.de. [91.64.150.195])
        by smtp.gmail.com with ESMTPSA id d19sm3252121wrb.7.2019.08.28.03.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 03:23:21 -0700 (PDT)
Date:   Wed, 28 Aug 2019 12:23:19 +0200
From:   Krzysztof Wilczynski <kswilczynski@gmail.com>
Subject: Re: [PATCH] PCI: Move static keyword to the front of declarations in
 pci-bridge-emul.c
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Message-Id: <1566987800.26704.0@gmail.com>
In-Reply-To: <20190827233017.GK9987@google.com>
References: <20190826151436.4672-1-kw@linux.com>
        <20190827233017.GK9987@google.com>
X-Mailer: geary/3.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Bjorn and Thomas,

Thank you for the feedback.

[...]
>>  Move the static keyword to the front of declarations of
>>  pci_regs_behavior and pcie_cap_regs_behavior, and resolve
>>  compiler warning that can be seen when building with
>>  warnings enabled (W=1).
> 
> It would be useful to include the compiler warning in the commit log.

Good point.  Sorry about that.  I will send a v2 that includes
updated commit message.

> I notice there are a few similar occurrences elsewhere in the tree:
> 
>   arch/csky/kernel/perf_event.c:const static struct of_device_id 
> csky_pmu_of_device_ids[] = {
>   arch/nds32/kernel/perf_event_cpu.c:const static struct of_device_id 
> cpu_pmu_of_device_ids[] = {
>   drivers/gpu/drm/msm/dsi/dsi_cfg.c:const static struct 
> msm_dsi_host_cfg_ops msm_dsi_v2_host_ops = {
>   drivers/gpu/drm/msm/dsi/dsi_cfg.c:const static struct 
> msm_dsi_host_cfg_ops msm_dsi_6g_host_ops = {
>   drivers/gpu/drm/msm/dsi/dsi_cfg.c:const static struct 
> msm_dsi_host_cfg_ops msm_dsi_6g_v2_host_ops = {
>   drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c:const static 
> struct wiphy_iftype_ext_capab he_iftypes_ext_capa[] = {
>   fs/unicode/utf8-selftest.c:const static struct {
>   fs/unicode/utf8-selftest.c:const static struct {
> 
> Those should probably be fixed, too (but in separate patches since
> other maintainers would take them).

I will take care about these too.

Krzysztof


