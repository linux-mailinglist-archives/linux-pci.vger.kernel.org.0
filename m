Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2447629F754
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 23:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725562AbgJ2WDu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Oct 2020 18:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgJ2WDu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Oct 2020 18:03:50 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B650EC0613CF;
        Thu, 29 Oct 2020 15:03:48 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id r186so3501461pgr.0;
        Thu, 29 Oct 2020 15:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:thread-topic:thread-index:date:message-id
         :references:in-reply-to:accept-language:content-language
         :content-transfer-encoding:mime-version;
        bh=ZdeDbEelXkHD28pDjWnxpVNwRGKME/CRICSzzS+Jp78=;
        b=FbjwJ+QbV5iiBNQ7QP2ZQgev2Am0A9rWNQyv5vrXiO6dBHcuDw0SZDQf5GFS9y2mST
         wos6gxJ9R8X/L04KIt7uIS9O1EcqTV0A25yeCyknkPuC7tZtH0hinTNVgosQHDR1gwZX
         UNKbPLkzIKoxfbb0r3fsrMNau2MWYakRQ7OQ8YW+Uf4t0WvrUiSfo8GtoxIhtmaZgoiT
         0L4iYCqXzuTUn+E2BQRoUp6G6O75WAdK0p0JlfaLlYAREIYiT1zdjKuCMj1te1nb7/UB
         az5pVECaQgOWIhM+fpDD+5XuagjjLZ6kD4Jfv1e768KJzYt/N7zXCvaI7gv5meZYx8WK
         +HLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:thread-topic:thread-index
         :date:message-id:references:in-reply-to:accept-language
         :content-language:content-transfer-encoding:mime-version;
        bh=ZdeDbEelXkHD28pDjWnxpVNwRGKME/CRICSzzS+Jp78=;
        b=o3eMWEesLazHWC6C2MpxiVFe1Z1o6tJxmg996rMZsAiYIeImbC00MroWpugp/o4sIr
         oneko9NOIpe5Zn801q8UJs891ztSd2p6LblISVIDfGLI1hiyINov64UQsqHoEykVASa4
         zx2O6w62WPRFXds2E4VBYVHlZ91m/gzDCK+cc7+l0Cc9ghjeCw8FPB0sXR6Xwm0/8ySJ
         sMS88jAmLOA9GVtW2noO33w9cNKSxXkaP+b/UP4re571zOi4jlU7iX4qhcjQHduSC0mM
         KrnTUh+rG5oSSAT4PXEivVHyOdtKr2yydRw4toy7BUOzfgmfD1SMGD8JVYj8vglx1Ni+
         V4IQ==
X-Gm-Message-State: AOAM533wbu9r2uh+l0mFqqdJpswgFofDd9+LNrj7vg8EEFNgiqeguDF2
        df6hh0nK0NHlsUMhdoQjXlU=
X-Google-Smtp-Source: ABdhPJy8PGWf7UR7rEkqPe7tAZ+6CAEca+KAriOcAJ0hoYyJgj5Xh0Lnh8k747xMrRF1zFuhfJ6WpA==
X-Received: by 2002:a17:90a:1690:: with SMTP id o16mr1325029pja.148.1604009028349;
        Thu, 29 Oct 2020 15:03:48 -0700 (PDT)
Received: from SL2P216MB0475.KORP216.PROD.OUTLOOK.COM ([2603:1046:100:19::5])
        by smtp.gmail.com with ESMTPSA id gm14sm846740pjb.2.2020.10.29.15.03.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2020 15:03:47 -0700 (PDT)
From:   Jingoo Han <jingoohan1@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "amurray@thegoodpenguin.co.uk" <amurray@thegoodpenguin.co.uk>,
        "robh@kernel.org" <robh@kernel.org>,
        "treding@nvidia.com" <treding@nvidia.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kthota@nvidia.com" <kthota@nvidia.com>,
        "mmaddireddy@nvidia.com" <mmaddireddy@nvidia.com>,
        "sagar.tv@gmail.com" <sagar.tv@gmail.com>,
        Han Jingoo <jingoohan1@gmail.com>
Subject: Re: [PATCH V3 2/2] PCI: dwc: Add support to configure for ECRC
Thread-Topic: [PATCH V3 2/2] PCI: dwc: Add support to configure for ECRC
Thread-Index: AQHWrbYA7JmObBkfy0Gh1N3xXvCmtKmvI0h3
X-MS-Exchange-MessageSentRepresentingType: 1
Date:   Thu, 29 Oct 2020 22:03:41 +0000
Message-ID: <SL2P216MB04759A928ACAA6F411718E01AA140@SL2P216MB0475.KORP216.PROD.OUTLOOK.COM>
References: <20201029053959.31361-1-vidyas@nvidia.com>
 <20201029053959.31361-3-vidyas@nvidia.com>
In-Reply-To: <20201029053959.31361-3-vidyas@nvidia.com>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator: 
X-MS-Exchange-Organization-RecordReviewCfmType: 0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 10/29/20, 1:40 AM, Vidya Sagar wrote:
>=20
> DesignWare core has a TLP digest (TD) override bit in one of the control
> registers of ATU. This bit also needs to be programmed for proper ECRC
> functionality. This is currently identified as an issue with DesignWare
> IP version 4.90a. This patch does the required programming in ATU upon
> querying the system policy for ECRC.
>
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Reviewed-by: Jingoo Han <jingoohan1@gmail.com>

No, it should be Acked-by. I gave you Acked-by, not Reviewed-by.

Acked-by: Jingoo Han <jingoohan1@gmail.com>


Best regards,
Jingoo Han

> ---
> V3:
> * Added 'Reviewed-by: Jingoo Han <jingoohan1@gmail.com>'
>
> V2:
> * Addressed Jingoo's review comment
> * Removed saving 'td' bit information in 'dw_pcie' structure
>
>  drivers/pci/controller/dwc/pcie-designware.c | 8 ++++++--
>  drivers/pci/controller/dwc/pcie-designware.h | 1 +
>  2 files changed, 7 insertions(+), 2 deletions(-)

[...]
