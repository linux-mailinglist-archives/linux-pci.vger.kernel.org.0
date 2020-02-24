Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD3016AC60
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2020 17:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgBXQ53 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Feb 2020 11:57:29 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38685 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727874AbgBXQ53 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Feb 2020 11:57:29 -0500
Received: by mail-ot1-f67.google.com with SMTP id z9so9327833oth.5;
        Mon, 24 Feb 2020 08:57:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6g/0/6uHeJ9SHvtHOygjn4v068gQNv45K/NSYSZDP4E=;
        b=U4bVxMHNwJ6W7JIAPFLUPteLmJJA0QGPR31VfFdSP8+ZGFAdgDOYzlj0ym5qD1aIJM
         Bmib+pRnAW4kq0/k8psdKx5rpJLLXoV8zu5Qv6C5XJPUuHov3HldBPDZwnhZVekqAkfy
         aQymTIFOScZk02GEXFHyuE75t4Zhw0GfDZCgFqSD+Z//bMVDFVmUS5Hyc4GPJkISlo2u
         VTf962Unq7aK78r8TtxckMzbAf7f0I4aJKmv4nco3IKg8Y8POpM5s+xspmcX5WZII3q9
         CkHNZBug1qUSRBzuSut9u2erF2aRNolrksI7E4U6j7w9nf8Mp1s/CF5ZSwK4kaOP5hIL
         Sq/g==
X-Gm-Message-State: APjAAAXpeCOe1ykqxhRx9rHz7u29dcVf1xT9Zuap25zZ3IkYOHbr/NW7
        /jPesK7HPXFUGqWp4eDsgg==
X-Google-Smtp-Source: APXvYqzBSMqtk4LzoxQnFIH5IwbuCE4Q4g+OfNbeilXK0aQ5gXGWn1SAYGX3ICKI7wCB5mXfcqXu7A==
X-Received: by 2002:a05:6830:1d8b:: with SMTP id y11mr42737812oti.4.1582563448155;
        Mon, 24 Feb 2020 08:57:28 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a1sm4610066oti.2.2020.02.24.08.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 08:57:27 -0800 (PST)
Received: (nullmailer pid 27821 invoked by uid 1000);
        Mon, 24 Feb 2020 16:57:26 -0000
Date:   Mon, 24 Feb 2020 10:57:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     David Daney <david.daney@cavium.com>,
        Robert Richter <rrichter@marvell.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, Joe Perches <joe@perches.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: clean up PCIE DRIVER FOR CAVIUM THUNDERX
Message-ID: <20200224165726.GA27161@bogus>
References: <20200223090950.5259-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200223090950.5259-1-lukas.bulwahn@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Feb 23, 2020 at 10:09:50AM +0100, Lukas Bulwahn wrote:
> Commit e1ac611f57c9 ("dt-bindings: PCI: Convert generic host binding to
> DT schema") combines all information from pci-thunder-{pem,ecam}.txt
> into host-generic-pci.yaml, and deleted the two files in
> Documentation/devicetree/bindings/pci/.
> 
> Since then, ./scripts/get_maintainer.pl --self-test complains:
> 
>   no file matches F: Documentation/devicetree/bindings/pci/pci-thunder-*
> 
> As the PCIE DRIVER FOR CAVIUM THUNDERX-relevant information is only a
> small part of the host-generic-pci.yaml, do not add this file to the
> PCIE DRIVER FOR CAVIUM THUNDERX entry, and only drop the reference to
> the removed files.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Robert, are you still the maintainer of this driver?
> Rob Herring, please pick this patch.
> applies cleanly on current master and next-20200221

Applied, thanks.

Rob
