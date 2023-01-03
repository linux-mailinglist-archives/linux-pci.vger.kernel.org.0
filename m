Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0976D65C22E
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jan 2023 15:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjACOq2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Jan 2023 09:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237290AbjACOqJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Jan 2023 09:46:09 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AA5F0E;
        Tue,  3 Jan 2023 06:46:05 -0800 (PST)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 835FFFF810;
        Tue,  3 Jan 2023 14:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1672757164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5cINJIua4peOqT9cWFpKeXfU505zcgniCHnXxC3iLO8=;
        b=etunyFc4nOV4uXp2vPS2Xx3bLvqpH03ijNGXiDIRgCjOI1MVX0kuvV6spzH9D7UTMeMhf8
        8Tdn2njgkhxCp+enCRf0bMOVNsVVbKjxdlV+WQN+6xtD8ENwCWuBIg3FNxBUi5+iDZ8ZPs
        h2TLdilxZ1khuyyBCMvZr36R9lKVEBP3S0x1RpJ97dBHdvFAEy6z9gXHjbvp8B1K6pmDxf
        WgqPCHbrQL+jHt6YD3TKCAY4809zPPqit0m9wp0yQp1jCOUJ0FLYUhirYLB6uCfJbIWCqq
        fvoXJh57SLxC7voS7mL11GqkorKhxq6rNHRhXYTyWbyAlVojAMlFsWBRVRCfNQ==
Date:   Tue, 3 Jan 2023 15:48:11 +0100
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
To:     Lizhi Hou <lizhi.hou@amd.com>
Cc:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>,
        <frowand.list@gmail.com>, <helgaas@kernel.org>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <larry.liu@amd.com>, <brian.xu@amd.com>,
        <stefano.stabellini@xilinx.com>, <trix@redhat.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "Allan.Nielsen@microchip.com" <Allan.Nielsen@microchip.com>,
        "Horatiu.Vultur@microchip.com" <Horatiu.Vultur@microchip.com>,
        "Steen.Hegelund@microchip.com" <Steen.Hegelund@microchip.com>
Subject: Re: [PATCH V5 2/3] PCI: Create device tree node for selected
 devices
Message-ID: <20230103154811.63e71494@fixe.home>
In-Reply-To: <1671125446-57584-3-git-send-email-lizhi.hou@amd.com>
References: <1671125446-57584-1-git-send-email-lizhi.hou@amd.com>
        <1671125446-57584-3-git-send-email-lizhi.hou@amd.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Le Thu, 15 Dec 2022 09:30:45 -0800,
Lizhi Hou <lizhi.hou@amd.com> a =C3=A9crit :

> +
> +static int of_pci_prop_address_cells(struct pci_dev *pdev,
> +				     struct of_changeset *ocs,
> +				     struct device_node *np)
> +{
> +	return of_changeset_add_prop_u32(ocs, np, "#address_cells",
> +					 OF_PCI_ADDRESS_CELLS);
> +}

Hi Lizhi,

This should be #address-cells and not #address_cells.

> +
> +static int of_pci_prop_size_cells(struct pci_dev *pdev,
> +				  struct of_changeset *ocs,
> +				  struct device_node *np)
> +{
> +	return of_changeset_add_prop_u32(ocs, np, "#size_cells",
> +					 OF_PCI_SIZE_CELLS);
> +}

Ditto here, this should be #size-cells and not #size_cells. Was this
really tested ?

Thanks,

--=20
Cl=C3=A9ment L=C3=A9ger,
Embedded Linux and Kernel engineer at Bootlin
https://bootlin.com
