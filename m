Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7AE0391FD8
	for <lists+linux-pci@lfdr.de>; Wed, 26 May 2021 20:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235088AbhEZTA6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 May 2021 15:00:58 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50962 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235002AbhEZTAy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 May 2021 15:00:54 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14QIxI8L081348;
        Wed, 26 May 2021 13:59:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622055558;
        bh=JLcWqo1gmuLZYUBwMCf24rWQmk458CRJORnK4CRGahE=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=ZQAnaxnyoVwawvoO/mgYv6PGDSOSEGYLVtHvWZIXSKMRzTaQYhGE7FYaRlL+LxCgw
         0Svj3UJHKOVBtLka4u4058mFXOKyAFTYaFhB9nPYSfwS38lprEEY4qqdgYx+ckQAyx
         K1ywcUIsmHZj7bf/CZwM47LZv6a6jGWSNa3VshGY=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14QIxICo097251
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 May 2021 13:59:18 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 26
 May 2021 13:59:17 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 26 May 2021 13:59:17 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14QIxHAM078148;
        Wed, 26 May 2021 13:59:17 -0500
Date:   Wed, 26 May 2021 13:59:17 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        PCI <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH] dt-bindings: PCI: ti,am65: Convert PCIe host/endpoint
 mode dt-bindings to YAML
Message-ID: <20210526185917.23icpjsuc37x3pae@slashing>
References: <20210526134708.27887-1-kishon@ti.com>
 <20210526140902.lnk5du5k3b4sny3m@handheld>
 <CAL_Jsq+7AD4WXggRrVVb=HKVmuomda3KVXuC1mcjYwbgnWRUkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+7AD4WXggRrVVb=HKVmuomda3KVXuC1mcjYwbgnWRUkg@mail.gmail.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11:04-20210526, Rob Herring wrote:

[...]

> > > +unevaluatedProperties: false
> >
> > Is it possible to lock this down further with additionalProperties: false?
> 
> unevaluatedProperties is what we want here.
> 
> > I could add some ridiculous property like system-controller; to the
> > example and the checks wont catch it.
> 
> Yes, because unevaluatedProperties is currently unimplemented. Once
> the upstream jsonschema tool supports it[1], there will be warnings.
> The other way we could address this is there are $ref resolving tools
> that flatten schemas.
> 
> [1] https://github.com/Julian/jsonschema/issues/613#issuecomment-636026577


Aha.. Thanks.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
