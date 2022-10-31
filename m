Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07718613508
	for <lists+linux-pci@lfdr.de>; Mon, 31 Oct 2022 12:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbiJaL5H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Oct 2022 07:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbiJaL4y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Oct 2022 07:56:54 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43FEF002;
        Mon, 31 Oct 2022 04:56:48 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29VArWGP038238;
        Mon, 31 Oct 2022 11:56:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=HLI3SRqnktCPesMn85xwWlxW9Kt1hv54yFxWdH6/rVA=;
 b=YK59Vo7Uv6HwXyN3akcRDmorvyo+XDg28W7dAmGrjQby83BXy6csN8W2wb9usJgQv9SL
 nzlwwZdcc9sMLZC7DEuAuO8AVD6c5W207wIrL2QDQwTtMTNBaL9OK/aDdB5QHAqKhDTz
 bymcJhh35kQ7sscr2yasQNZUyKWY5VbjURTPWRA45yPJYdBd20h37/WKtmE1vMds7Rez
 mDf4N4IRnhoHiTnsY3vGNeuGKjsKzBGKkCYok2YEWMnr2gxeaBgNmH9obJISQNfLNKNh
 g7EGnj+X1oi0H4moNr9dmvOdO0TuqGmD0MYPq1sZsDnvawyCiysS2oOXJV9ld2GtwXzu 0g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kjb6dn0p4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Oct 2022 11:56:40 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29VBFgnS039529;
        Mon, 31 Oct 2022 11:56:39 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kjb6dn0ns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Oct 2022 11:56:39 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29VBqftD026711;
        Mon, 31 Oct 2022 11:56:37 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3kgut92vme-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Oct 2022 11:56:37 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29VBuZwi54460854
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Oct 2022 11:56:35 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4AF4752050;
        Mon, 31 Oct 2022 11:56:35 +0000 (GMT)
Received: from sig-9-145-54-171.uk.ibm.com (unknown [9.145.54.171])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id C6DC15204F;
        Mon, 31 Oct 2022 11:56:34 +0000 (GMT)
Message-ID: <ed791d5270ce8684085b47d83332ef0aa172e1d0.camel@linux.ibm.com>
Subject: Re: [PATCH] PCI: Fix dropping valid root bus resources with .end =
 zero
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Rob Herring <robh@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 31 Oct 2022 12:56:34 +0100
In-Reply-To: <9c41a4372b27420c732ff5599d823e363de00c6d.1657704829.git.geert+renesas@glider.be>
References: <9c41a4372b27420c732ff5599d823e363de00c6d.1657704829.git.geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1EEdZhvZt2hDqtrdpMqtoSfRGLH5lkLo
X-Proofpoint-ORIG-GUID: 5ZP_22kxC4NQpF9LKytck26cnd18jGG5
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-31_13,2022-10-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501
 clxscore=1011 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210310073
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2022-07-13 at 11:35 +0200, Geert Uytterhoeven wrote:
> On r8a7791/koelsch:
> 
>     kmemleak: 1 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
>     # cat /sys/kernel/debug/kmemleak
>     unreferenced object 0xc3a34e00 (size 64):
>       comm "swapper/0", pid 1, jiffies 4294937460 (age 199.080s)
>       hex dump (first 32 bytes):
> 	b4 5d 81 f0 b4 5d 81 f0 c0 b0 a2 c3 00 00 00 00  .]...]..........
> 	00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>       backtrace:
> 	[<fe3aa979>] __kmalloc+0xf0/0x140
> 	[<34bd6bc0>] resource_list_create_entry+0x18/0x38
> 	[<767046bc>] pci_add_resource_offset+0x20/0x68
> 	[<b3f3edf2>] devm_of_pci_get_host_bridge_resources.constprop.0+0xb0/0x390
> 
> When coalescing two resources for a contiguous aperture, the first
> resource is enlarged to cover the full contiguous range, while the
> second resource is marked invalid.  This invalidation is done by
> clearing the flags, start, and end members.
> 
> When adding the initial resources to the bus later, invalid resources
> are skipped.  Unfortunately, the check for an invalid resource considers
> only the end member, causing false positives.
> 
> E.g. on r8a7791/koelsch, root bus resource 0 ("bus 00") is skipped, and
> no longer registered with pci_bus_insert_busn_res() (causing the memory
> leak), nor printed:
> 
>      pci-rcar-gen2 ee090000.pci: host bridge /soc/pci@ee090000 ranges:
>      pci-rcar-gen2 ee090000.pci:      MEM 0x00ee080000..0x00ee08ffff -> 0x00ee080000
>      pci-rcar-gen2 ee090000.pci: PCI: revision 11
>      pci-rcar-gen2 ee090000.pci: PCI host bridge to bus 0000:00
>     -pci_bus 0000:00: root bus resource [bus 00]
>      pci_bus 0000:00: root bus resource [mem 0xee080000-0xee08ffff]
> 
> Fix this by only skipping resources where all of the flags, start, and
> end members are zero.
> 
> Fixes: 7c3855c423b17f6c ("PCI: Coalesce host bridge contiguous apertures")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Is there any side effect of not registering the root bus resource with
> pci_bus_insert_busn_res()?  This is the resource created by
> of_pci_parse_bus_range(), and thus affects any DT platforms using
> "bus-range = <0 0>".
> 
> Perhaps checking for "!res->flags" would be sufficient?
> 
> I assume this still causes memory leaks on systems where resources are
> coalesced, as the second resource of a contiguous aperture is no longer
> referenced? Perhaps instead of clearing the resource, it should be
> removed from the list (and freed? is it actually safe to do that?)?
> 
> Apparently Johannes had identified the bug before, but didn't realize
> the full impact...
> https://lore.kernel.org/r/5331e942ff28bb191d62bb403b03ceb7d750856c.camel@sipsolutions.net/
> ---
>  drivers/pci/probe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 17a969942d37033a..be628798d279ada0 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -994,7 +994,7 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>  	resource_list_for_each_entry_safe(window, n, &resources) {
>  		offset = window->offset;
>  		res = window->res;
> -		if (!res->end)
> +		if (!res->flags && !res->start && !res->end)
>  			continue;
>  
>  		list_move_tail(&window->node, &bridge->windows);

Hi Geert, Hi Bjorn, Hi Kai-Heng,

I just stumbled over this issue on s390 with the below kmemleak
splat[0]. On s390 we currently always have a single PCI bus with bus
number 00 per PCI domain so this is triggered whenever there are PCI
devices attached to the system.

Applying the patch from this mail makes the splat go away and the
'pci_bus 0002:00: root bus resource [bus 00]' message reappear. As this
mail is from July I guess it got lost and this was never picked up ;-(

Looking at the commit message and code I'm left with the same questions
as Geert added below the '---' line, so further changes might be needed
for the coalescing case. Either way without this patch the above if
incorrectly skips the root bus resource for us and I think '!res->end'
is just incorrect as a check for invalidity. Geert's proposed change on
the other hand looks correct to me though I do think that the better
solution would be to drop this if and remove the invalidated resource.
The loop even uses '..._for_each_entry_safe' so I would assume removing
it should be okay? This does look a bit like the expansion case in
acpi_pci_root_validate_resources().

For now feel free to add my:

Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>

Thanks,
Niklas
 
[0]:
unreferenced object 0x880e20d0 (size 96):
  comm "swapper/0", pid 1, jiffies 4294937765 (age 3029.430s)
  hex dump (first 32 bytes):
    00 00 03 7f ff b1 ba e0 00 00 03 7f ff b1 ba e0  ................
    00 00 00 00 88 1a 18 30 00 00 00 00 00 00 00 00  .......0........
  backtrace:
    [<00000003c0151e6c>] __kmem_cache_alloc_node+0x204/0x438
    [<00000003c00c0a88>] __kmalloc+0x58/0xf0
    [<00000003bfe34a9e>] resource_list_create_entry+0x2e/0x60
    [<00000003c075ea8a>] pci_add_resource+0x32/0x98
    [<00000003bfe22f14>] zpci_bus_device_register+0x124/0x3c0
    [<00000003bfe1baf2>] zpci_create_device+0x142/0x1d0
    [<00000003bfe1fe4c>] clp_scan_pci_devices+0xfc/0x150
    [<00000003c189a468>] pci_base_init+0x148/0x1b0
    [<00000003bfdd4ab0>] do_one_initcall+0x78/0x388
    [<00000003c189081c>] do_initcalls+0x12c/0x150
    [<00000003c1890b1e>] kernel_init_freeable+0x25e/0x2a0
    [<00000003c0bb5136>] kernel_init+0x2e/0x170
    [<00000003bfdd7914>] __ret_from_fork+0x3c/0x58
    [<00000003c0bc79fa>] ret_from_fork+0xa/0x40

