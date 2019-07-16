Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBB9A6A1AA
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2019 06:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfGPE63 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Jul 2019 00:58:29 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44390 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfGPE63 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Jul 2019 00:58:29 -0400
Received: by mail-wr1-f65.google.com with SMTP id p17so19308766wrf.11;
        Mon, 15 Jul 2019 21:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=DAH6dKwCyAbLlDOpi+3YA8QHS8AaWmvdyvdCSPTEF0Y=;
        b=nS2o8Fm9M4Qr66Q30/2C6MH1XD+GoJrUGw89RjxqqLMPy/N0vMS4aNGEcaxYAJnIX5
         SMPnUb15ISTTidfbY8LA1hNqNSHrVaySeORVyNQIozPHNfJbfYm1KmEWWBGaRpMyedso
         S2zxddiS33osopW5ZauwrcBDxU4V2MLZfCjvABdQ3x5s1cg8fnlKIR3+w30ChaFjxvJP
         JBW5gE9xk9NHewAXNzvH8+ZLk+mRQ51auejRMC3/N52dzZztGdUrVNlJviAPQJU972ml
         2+f02WEkshrB/oh97WenpnRP9UJjeamWtgIy1jp0ssFoe7lcA2RDYAy5O4KSpAxPvQ+0
         3vyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=DAH6dKwCyAbLlDOpi+3YA8QHS8AaWmvdyvdCSPTEF0Y=;
        b=RmmCjkJkQXEPSLvWCtAXnMTlLyWzDuMqbg1HlZTMRsEnf9TrGmAR+1LGrGHW4fjsZI
         Z4m8B7aWsK//ba9Mk7/NdcCCn6leFvnoadM6OgbOb1ioy4xKM9sN5VSYwPFu8BZV/Uml
         vOYAr9eVUEYd22HwMN7Ssv2Ks5DQ+oor0eHfDJrvpcuyDwc/Dcnt7ZxnqGihv9sMgAEf
         MMAxHpX00xx0n2QoqF2Jp16y+HfJrjmy8kdIR4/deAqIGAZ/vVtj9mVMmft5i16nnzSv
         lTkjee6+HunwRfMsuH6q/LjClFXiy7MroqPlVDjxh9xile4/jsMXCOm7FMJFQMRrUnQX
         SB0A==
X-Gm-Message-State: APjAAAWabuB5yBdhyzp56Ma5nhmz75SLeQWmJatAWWsA9K62v68vS55d
        zgv5R78DYJwXLIlc8Wbco54=
X-Google-Smtp-Source: APXvYqzr38ksHGsl/DwWofhZwIvO6atz4K0RW1TCfzVhr13qTsXUsftSgaCT7giy8X8bGABmOvhmgw==
X-Received: by 2002:a5d:468a:: with SMTP id u10mr33323669wrq.177.1563253107137;
        Mon, 15 Jul 2019 21:58:27 -0700 (PDT)
Received: from felia ([2001:16b8:2d8a:7300:3de9:10dd:67c8:ed32])
        by smtp.gmail.com with ESMTPSA id j10sm32668442wrd.26.2019.07.15.21.58.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 21:58:26 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Tue, 16 Jul 2019 06:58:15 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Kelsey Skunberg <skunberg.kelsey@gmail.com>
cc:     linux-pci@vger.kernel.org, bhelgaas@google.com,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [Linux-kernel-mentees] [PATCH v3] PCI: Remove functions not
 called in include/linux/pci.h
In-Reply-To: <20190715203416.37547-1-skunberg.kelsey@gmail.com>
Message-ID: <alpine.DEB.2.21.1907160653150.3426@felia>
References: <20190715181312.31403-1-skunberg.kelsey@gmail.com> <20190715203416.37547-1-skunberg.kelsey@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On Mon, 15 Jul 2019, Kelsey Skunberg wrote:

> Remove the following uncalled functions from include/linux/pci.h:
> 
>         pci_block_cfg_access()
>         pci_block_cfg_access_in_atomic()
>         pci_unblock_cfg_access()
> 
> Functions were added in commit fb51ccbf217c ("PCI: Rework config space
> blocking services"), though no callers were added. Code continues to be
> unused and should be removed.
> 
> Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
> ---
> 
> Changes since v1:
>   - Fixed Signed-off-by line to show full name
> 
> Changes since v2:
>   - Change commit message to reference prior commit properly with the
>     following format:
> 	commit <12-character sha prefix> ("<commit message>")
> 
>  include/linux/pci.h | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index cf380544c700..3c9ba6133bea 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1656,11 +1656,6 @@ static inline void pci_release_regions(struct pci_dev *dev) { }
>  
>  static inline unsigned long pci_address_to_pio(phys_addr_t addr) { return -1; }
>  
> -static inline void pci_block_cfg_access(struct pci_dev *dev) { }
> -static inline int pci_block_cfg_access_in_atomic(struct pci_dev *dev)
> -{ return 0; }
> -static inline void pci_unblock_cfg_access(struct pci_dev *dev) { }
> -
>  static inline struct pci_bus *pci_find_next_bus(const struct pci_bus *from)
>  { return NULL; }
>  static inline struct pci_dev *pci_get_slot(struct pci_bus *bus,
> -- 
> 2.20.1

I just checked with elixir on v5.2 that all three identifiers are never 
referenced beyond its definition in pci.h:

https://elixir.bootlin.com/linux/v5.2/ident/pci_block_cfg_access
https://elixir.bootlin.com/linux/v5.2/ident/pci_block_cfg_access_in_atomic
https://elixir.bootlin.com/linux/v5.2/ident/pci_unblock_cfg_access

So, what it is worth:

Reviewed-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Lukas

> 
> _______________________________________________
> Linux-kernel-mentees mailing list
> Linux-kernel-mentees@lists.linuxfoundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/linux-kernel-mentees
> 
