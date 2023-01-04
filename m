Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7BB865CCB5
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jan 2023 06:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjADF5d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Jan 2023 00:57:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233194AbjADF5Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jan 2023 00:57:24 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AD217E01;
        Tue,  3 Jan 2023 21:57:17 -0800 (PST)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 66F24C0003;
        Wed,  4 Jan 2023 05:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1672811836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aaHO5HW0/jdyJgkDv80hMQrubxOJMAsxdLC43TtMutA=;
        b=MVsw7RD7e/dmgFjFFlzS3wJbIzgCtceXUQz8DUjxIfIQvDZVb9e42V/XYROwutZLoEFvJ6
        Kmf1mcQAxBnKnDHFiJ8RGiF698Kb5NaptrYVwhsXNK8NhdpCbBNWVmTQA1D1jclhFRUp6v
        WeBcmYyTfM3NQq08Y2CRqulBy/Cto9xcOaW5sAt8es82F+YbEG4PqKBwHEcFqLH2oyoVwv
        sPr9EPVrxxi4UvW4TQdByi64QAb0866m+byNLFegin+880F6Dv8/ZvzKfVhYZUJrE/kyP7
        tJgy1n/1lYvQ0fxx7NOIhrXIGOH7v4RcsfXfvtctUuvpaLCGlbujpnskHxm0Ew==
MIME-Version: 1.0
Date:   Wed, 04 Jan 2023 06:57:14 +0100
From:   clement.leger@bootlin.com
To:     Lizhi Hou <lizhi.hou@amd.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh@kernel.org,
        frowand.list@gmail.com, helgaas@kernel.org, max.zhen@amd.com,
        sonal.santan@amd.com, larry.liu@amd.com, brian.xu@amd.com,
        stefano.stabellini@xilinx.com, trix@redhat.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan.Nielsen@microchip.com, Horatiu.Vultur@microchip.com,
        Steen.Hegelund@microchip.com
Subject: Re: [PATCH V5 2/3] PCI: Create device tree node for selected devices
In-Reply-To: <bee02801-c3a4-4717-61a0-290494a097bc@amd.com>
References: <1671125446-57584-1-git-send-email-lizhi.hou@amd.com>
 <1671125446-57584-3-git-send-email-lizhi.hou@amd.com>
 <20230103154811.63e71494@fixe.home>
 <bee02801-c3a4-4717-61a0-290494a097bc@amd.com>
Message-ID: <7eb33924fc380669893571747b999660@bootlin.com>
X-Sender: clement.leger@bootlin.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Le 2023-01-04 01:31, Lizhi Hou a écrit :
> On 1/3/23 06:48, Clément Léger wrote:
>> Le Thu, 15 Dec 2022 09:30:45 -0800,
>> Lizhi Hou <lizhi.hou@amd.com> a écrit :
>> 
>>> +
>>> +static int of_pci_prop_address_cells(struct pci_dev *pdev,
>>> +				     struct of_changeset *ocs,
>>> +				     struct device_node *np)
>>> +{
>>> +	return of_changeset_add_prop_u32(ocs, np, "#address_cells",
>>> +					 OF_PCI_ADDRESS_CELLS);
>>> +}
>> Hi Lizhi,
>> 
>> This should be #address-cells and not #address_cells.
>> 
>>> +
>>> +static int of_pci_prop_size_cells(struct pci_dev *pdev,
>>> +				  struct of_changeset *ocs,
>>> +				  struct device_node *np)
>>> +{
>>> +	return of_changeset_add_prop_u32(ocs, np, "#size_cells",
>>> +					 OF_PCI_SIZE_CELLS);
>>> +}
>> Ditto here, this should be #size-cells and not #size_cells. Was this
>> really tested ?
> 
> I will fix this.  I verified the properties are generated and did not
> notice the '_' error.

Hi Lizhi,

The most important thing to test is if a driver can correctly retrieve 
resource
of the device using a node added below the created PCI device node. This 
is
resolved using the whole hierarchy ranges, address-cells and size-cells 
properties.

If not correctly set, this will fail (and it fails).

Clément

> 
> 
> Thanks,
> 
> Lizhi
> 
>> 
>> Thanks,
>> 
