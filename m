Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 337C7351B9A
	for <lists+linux-pci@lfdr.de>; Thu,  1 Apr 2021 20:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237879AbhDASJA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Apr 2021 14:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235407AbhDASCl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Apr 2021 14:02:41 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B6AC031154
        for <linux-pci@vger.kernel.org>; Thu,  1 Apr 2021 09:48:21 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id x16so2478037wrn.4
        for <linux-pci@vger.kernel.org>; Thu, 01 Apr 2021 09:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V1mDpvuqnGJ8dPBR2OvhLT/0WD4buh61rulA5EoTQ9Q=;
        b=A0w+MZpZY9sazwO4uioINy18JBM8SDfCa+ORIbfVMlQiY+ptHmMCmvjYc7UxYe4TrF
         25DSLy7G0UZ4QNshcWW/f66hcEwEpLefPZWgaE9QY2Z1FGfpE8EKVje/4f/LlhTv9iOw
         ZIA/KDdoEWQbytleCk1E6P96jbEeuHBbarsgQtbjdKhNR8P0/MbJ9Da9HjdFMRHjIIK/
         zNo953xI4v/u5hPqghRhBrzkjCcDsKjUPL95MIzdC6ojDdhICaHU1y+R08DQp+YFI17e
         UXlkx6VcMZU/x64brBXdUcauE4Fh2K/CcNkFfYQTCVj/Ibks+4VdPfJI8RQrXfj0eEkh
         7MrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V1mDpvuqnGJ8dPBR2OvhLT/0WD4buh61rulA5EoTQ9Q=;
        b=SK0KikXBXlf3DOz0ITEQrjFeJPkw/37s3s0xv5SThYiBf5AORYagDrz9M6Q6thyaVP
         s658YPsHTwUkIAfOqxtd/fAINPPByNOkV7uqwyr6SuGu4qn7T9YDC5XopdDLT+UmdrdG
         N+ZWZfz8717bLV9ZP/4ffcs9f8HpuJrQRlvGi6H/e+A+kPql14ZftsX+DUQ+ekdRNlxV
         kZ1yEWxMf6iaYkEqyHH0lZOfaVLS5CdT2USMkMxCO9qcnEd6L8YjhptTsQyxRL8TtAlL
         tTJUjcNY07bN5oLUQJFpVe+ap0gOjyDDepTiIxafjgK3W8kqsMNIcSc6THHSeMPCHnSn
         4CMA==
X-Gm-Message-State: AOAM533YVXXpqAmVMkP2eIcGvKICnASwQmPrWoszU1wHBum3FPoLmzZ2
        qLFQ+xbjQyTZis5AhDBYUElCB8pj5w2vVw==
X-Google-Smtp-Source: ABdhPJwhpY7JcVizl9hdf8VRgTtACBg/TQ/pP8t9QFcc1IYJ6J2ELNYbNZrNigtnn6Yo+1V2ZNsgKg==
X-Received: by 2002:adf:e60e:: with SMTP id p14mr10828584wrm.221.1617295700032;
        Thu, 01 Apr 2021 09:48:20 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f1f:bb00:5544:e633:d47e:4b76? (p200300ea8f1fbb005544e633d47e4b76.dip0.t-ipconnect.de. [2003:ea:8f1f:bb00:5544:e633:d47e:4b76])
        by smtp.googlemail.com with ESMTPSA id y205sm11696165wmc.18.2021.04.01.09.48.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 09:48:19 -0700 (PDT)
Subject: Re: [PATCH 0/3] PCI/VPD: Some improvements
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <1a0155ce-6c20-b653-d319-58e6505a1a40@gmail.com>
Message-ID: <09cfc65f-b205-9a7d-1e77-e7d96bdbc44c@gmail.com>
Date:   Thu, 1 Apr 2021 18:48:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <1a0155ce-6c20-b653-d319-58e6505a1a40@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 01.04.2021 18:35, Heiner Kallweit wrote:
> This series includes some improvements. No functional change intended.
> 
> Heiner Kallweit (3):
>   PCI/VPD: Change pci_vpd_init return type to void
>   PCI/VPD: Remove argument off from pci_vpd_find_tag
>   PCI/VPD: Improve and simplify pci_vpd_find_tag
> 
>  drivers/net/ethernet/broadcom/bnx2.c          |  2 +-
>  .../net/ethernet/broadcom/bnx2x/bnx2x_main.c  |  3 +-
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  2 +-
>  drivers/net/ethernet/broadcom/tg3.c           |  4 +-
>  drivers/net/ethernet/chelsio/cxgb4/t4_hw.c    |  2 +-
>  drivers/net/ethernet/sfc/efx.c                |  2 +-
>  drivers/net/ethernet/sfc/falcon/efx.c         |  2 +-
>  drivers/pci/pci.h                             |  2 +-
>  drivers/pci/vpd.c                             | 40 +++++--------------
>  drivers/scsi/cxlflash/main.c                  |  3 +-
>  include/linux/pci.h                           |  3 +-
>  11 files changed, 21 insertions(+), 44 deletions(-)
> 
Forgot to say: This series is based on the pci/vpd branch.
