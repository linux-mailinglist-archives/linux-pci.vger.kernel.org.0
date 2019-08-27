Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5619E9F01C
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2019 18:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730047AbfH0Q0u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Aug 2019 12:26:50 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36685 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfH0Q0u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Aug 2019 12:26:50 -0400
Received: by mail-oi1-f194.google.com with SMTP id n1so15433321oic.3;
        Tue, 27 Aug 2019 09:26:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4HSp7GpMjayluxWHO7ugEoqBf1XE55/uOIFDoDgJv6Q=;
        b=jsB92w66Dst0WBEF8yw2f0Lm8mbvlzjPO0pIFtStcB/u9DwceX7WcM2QMnytrz5MAx
         AgWlpTD5NywTzhhihSS1jUMePbR3Bq8muc2djMMtE5eWAn2TXQJqEUwlQIQ84t/0Qnaj
         XUpmtQ1Rze1rM/D7wr1vrBHjtesmKv6iEmcO7vO1xLOi7oJyGUswDOhdSfxV+yLJPvta
         z4G1n0+1+P+bUdMfbsLXloWdUQDQFr4uYuwbz+F2p0uEcuxwTHPLiEaqly0A4s/7IzV+
         Aa/lu1kB52KjNPqTA7cnU5uXkB3FwgIp4Yi7fEiOwU/VP9DK5dLSOXqNySu89oYkLWd6
         ufDQ==
X-Gm-Message-State: APjAAAUrbm4vmxKhz7RB/zXWhtYYBlDuWJe5AciogHP5n3qfIMy8MjKO
        JQIxweq32YCuR8sUUttd2Q==
X-Google-Smtp-Source: APXvYqz+FEVhEUY3wCiucFQEMMkHkhySFHT9ozYmvRgI1VOAn+6/u4QwVBFFW28kEOM0vAnYZbB4fA==
X-Received: by 2002:aca:5652:: with SMTP id k79mr1967173oib.175.1566923209074;
        Tue, 27 Aug 2019 09:26:49 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c3sm5232759otm.70.2019.08.27.09.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 09:26:48 -0700 (PDT)
Date:   Tue, 27 Aug 2019 11:26:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Xiaowei Bao <xiaowei.bao@nxp.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, leoyang.li@nxp.com, kishon@ti.com,
        lorenzo.pieralisi@arm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, minghuan.Lian@nxp.com,
        mingkai.hu@nxp.com, roy.zang@nxp.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: Re: [PATCH 08/10] dt-bindings: PCI: Add the pf-offset property
Message-ID: <20190827162647.GA21347@bogus>
References: <20190815083716.4715-1-xiaowei.bao@nxp.com>
 <20190815083716.4715-8-xiaowei.bao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815083716.4715-8-xiaowei.bao@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 15 Aug 2019 16:37:14 +0800, Xiaowei Bao wrote:
> Add the pf-offset property for multiple PF.
> 
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> ---
>  Documentation/devicetree/bindings/pci/designware-pcie.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
