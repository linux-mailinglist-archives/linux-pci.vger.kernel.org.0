Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C47469B93
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2019 21:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730356AbfGOTm7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Jul 2019 15:42:59 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43493 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729598AbfGOTm7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Jul 2019 15:42:59 -0400
Received: by mail-wr1-f67.google.com with SMTP id p13so18338735wru.10;
        Mon, 15 Jul 2019 12:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ivvcy3jSvKNh7AY9v8j4FaWyMteFu4efIhrDaMrTgs0=;
        b=JL9pwKdRfzEgQuz6M6l0NwkbxKsmHvoTFiGXAoBw5hEY/u/A2CWfoFq4gSYEBLld9g
         q3soQgGUYTyf1DraKl/IE5xRYQDP1TM4ILvxl/QLYJlsqshYqTPe4LwIYeK/zOUoPf3T
         brFPEi/dN9AwVD16cam4NX6uSaA+amRANhulK4YLsyrl3Nfi72K/MAWB9QLpcG6/5BdV
         C8MdsU7YlJRANavLjtdxRK1P6SSoylaq3Pn2ta6g04BIlUQLXHEWNVTUYpV5jch7FXqP
         dvJzPPAqH/CL1THPIXbAstmhpppc4BhBtb68CwOpD5Iw1dqccwKrREre8FnPNMgxEerw
         jyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ivvcy3jSvKNh7AY9v8j4FaWyMteFu4efIhrDaMrTgs0=;
        b=QdxgFJU56+JMymZd9PFSIFNUNS+wVH9qCoA3VYGPo6s7vpeo7BxVGFGTiSObLG+Do7
         sj7mgTc+wrA9nIYExO2jDGVUTD6XkqJMa98tlMl9X677cMsgZWq32ncOrxQLwMCzuDrC
         tZezbHYYcR2GSrE84K+7ru0JgOWIU2+bU2ikh5SZ4LOL6EX8f0546HbYfWcoSKdd+raL
         9oZqAwfI8NlZbpGXs2m4n24nAoj3clwDNELwEgC09yzarigEUjCVed6vA/H8D2wovO0+
         k9e/Nj8ZafZWMYybXDyBTZ7v3lKaeybTGNgXk7ALtDWaWKhNFqPnBbL3xCHrCtTbOVrF
         RpPQ==
X-Gm-Message-State: APjAAAUUDMzWmfwA1HbtW+rF0tPUQbfzCMYV34mTuE0Gt1J/0AQQNS4U
        GhffK7D80A2LAN25NK6rgWI=
X-Google-Smtp-Source: APXvYqyEqpA1gOpTfq3syYAte0jdi7inc52XAxENBCxOvBZo2HSaroz6fSIklIcvS96/1smIuGr9tw==
X-Received: by 2002:adf:efc8:: with SMTP id i8mr721555wrp.220.1563219776662;
        Mon, 15 Jul 2019 12:42:56 -0700 (PDT)
Received: from felia ([2001:16b8:2dc5:2000:cd36:d602:4f2d:7917])
        by smtp.gmail.com with ESMTPSA id y1sm15121414wma.32.2019.07.15.12.42.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 12:42:55 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Mon, 15 Jul 2019 21:42:47 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Kelsey Skunberg <skunberg.kelsey@gmail.com>
cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [Linux-kernel-mentees] [PATCH v2] PCI: Remove functions not
 called in include/linux/pci.h
In-Reply-To: <20190715181312.31403-1-skunberg.kelsey@gmail.com>
Message-ID: <alpine.DEB.2.21.1907152138120.2564@felia>
References: <20190715175658.29605-1-skunberg.kelsey@gmail.com> <20190715181312.31403-1-skunberg.kelsey@gmail.com>
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
> Functions were added in patch fb51ccbf217c "PCI: Rework config space
> blocking services", though no callers were added. Code continues to be
> unused and should be removed.
> 
> Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
> ---
> 

Nice finding. How did you discover this issue? Did you use a tool to find 
this ununsed code or stumble over it during your code review?

Also note that commits are referred to with this format:

commit <12-character sha prefix> ("<commit message>")

So, you need to change patch to commit and include brackets around your
quoted commit message.

Lukas

> Changes since v1:
>   - Fixed Signed-off-by line to show full name
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
> 
> _______________________________________________
> Linux-kernel-mentees mailing list
> Linux-kernel-mentees@lists.linuxfoundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/linux-kernel-mentees
> 
