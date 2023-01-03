Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8056565C796
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jan 2023 20:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238708AbjACTfD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Jan 2023 14:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238216AbjACTfC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Jan 2023 14:35:02 -0500
X-Greylist: delayed 106847 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 03 Jan 2023 11:34:58 PST
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4087213E8B;
        Tue,  3 Jan 2023 11:34:58 -0800 (PST)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 4BEFA20005;
        Tue,  3 Jan 2023 19:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1672774496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TCSzlhuVMs/XD30WGxXGCTSW3adFD4OjPzifYM+Gnuk=;
        b=BJkpxvNHZVQOreNDNuUn0kbSKMcS46uKwxZIbDoZPxrNHNKKbC3gf32NuVS3kho92faSpe
        ch/HyJSLQLH+Qd4k23tvbqk7+GlUqOk2BxhEOi89n4L1/Osc9pjXiIRTSchVs9nv3Lrrgo
        F8ZnL9+rMs8c6+2kFEv4D1B6qjvZ8WDIy+Dbf38zZATW+7Q2kRqXIy0EIfo1zMHDi7OGoS
        YI9cPDRB9BmB13gKnySOLtLsBrKWjtyFo3JquoTqgRAZEufeYViZZoMtff5VaIs7pVXftn
        Bgesq0BH25efAyAVFI5bRoqB1L3VIYTKDcpYFcfm8rLf0uZOJwMJUvDdPWSpEg==
MIME-Version: 1.0
Date:   Tue, 03 Jan 2023 20:34:55 +0100
From:   clement.leger@bootlin.com
To:     Lizhi Hou <lizhi.hou@amd.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh@kernel.org,
        frowand.list@gmail.com, helgaas@kernel.org, max.zhen@amd.com,
        sonal.santan@amd.com, larry.liu@amd.com, brian.xu@amd.com,
        stefano.stabellini@xilinx.com, trix@redhat.com,
        Allan.Nielsen@microchip.com, Horatiu.Vultur@microchip.com,
        Steen.Hegelund@microchip.com
Subject: Re: [PATCH V5 2/3] PCI: Create device tree node for selected devices
In-Reply-To: <b50306fe-d710-4d11-d5e2-2b9c8293e44e@amd.com>
References: <1671125446-57584-1-git-send-email-lizhi.hou@amd.com>
 <1671125446-57584-3-git-send-email-lizhi.hou@amd.com>
 <20230102145618.4b5bace8@fixe.home>
 <b50306fe-d710-4d11-d5e2-2b9c8293e44e@amd.com>
Message-ID: <b9078b9583e35dce6113c344abe0ca69@bootlin.com>
X-Sender: clement.leger@bootlin.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Le 2023-01-03 19:44, Lizhi Hou a écrit :
> On 1/2/23 05:56, Clément Léger wrote:
>> Le Thu, 15 Dec 2022 09:30:45 -0800,
>> Lizhi Hou <lizhi.hou@amd.com> a écrit :
>> 
>>> +};
>>> +
>>> +static int of_pci_prop_device_type(struct pci_dev *pdev,
>>> +				   struct of_changeset *ocs,
>>> +				   struct device_node *np)
>>> +{
>>> +	return of_changeset_add_prop_string(ocs, np, "device_type", "pci");
>>> +}
>>> +
>>> +static int of_pci_prop_address_cells(struct pci_dev *pdev,
>>> +				     struct of_changeset *ocs,
>>> +				     struct device_node *np)
>>> +{
>>> +	return of_changeset_add_prop_u32(ocs, np, "#address_cells",
>>> +					 OF_PCI_ADDRESS_CELLS);
>>> +}
>>> +
>>> +static int of_pci_prop_size_cells(struct pci_dev *pdev,
>>> +				  struct of_changeset *ocs,
>>> +				  struct device_node *np)
>>> +{
>>> +	return of_changeset_add_prop_u32(ocs, np, "#size_cells",
>>> +					 OF_PCI_SIZE_CELLS);
>>> +}
>> Hi Lizhi,
>> 
>> For all these functions, the "pdev" parameter is actually unused.
>> 
>> [snip]
> Ok. I will remove unused pdev.
>> 
>>> +
>>> +static int of_pci_prop_compatible(struct pci_dev *pdev,
>>> +				  struct of_changeset *ocs,
>>> +				  struct device_node *np)
>>> +{
>>> +	const char *compat_strs[PROP_COMPAT_NUM] = { 0 };
>>> +	int i, ret;
>>> +
>>> +	compat_strs[PROP_COMPAT_PCI_VVVV_DDDD] =
>>> +		kasprintf(GFP_KERNEL, "pci%x,%x", pdev->vendor, pdev->device);
>> Maybe it should be better to use "pci%04x,%04x" to keep the existing
>> naming.
> 
> Based on
> https://www.devicetree.org/open-firmware/bindings/pci/pci2_1.pdf,
> "pci%x,%x" should be used?
> 
> "name" Based on the PCI Class Code register, pick a name from Table 1.
> If none apply, generate a name of the
> form pciVVVV,DDDD as described below under "compatible".
> 
> VVVV, DDDD, SSSS, ssss and RR are lower-case ASCII hexadecimal numbers
> without leading zeroes.

You might be right then ! I just looked at the already existing 
device-tree
which adds leading zeroes. Someone like Rob or Frank might be able to 
answer
on that.

Clément

> 
> 
> Thanks,
> 
> Lizhi
> 
>> 
