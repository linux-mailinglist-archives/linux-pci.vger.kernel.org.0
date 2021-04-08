Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86F8B358A58
	for <lists+linux-pci@lfdr.de>; Thu,  8 Apr 2021 18:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbhDHQ6L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Apr 2021 12:58:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:43438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230522AbhDHQ6L (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Apr 2021 12:58:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 77A23610A2;
        Thu,  8 Apr 2021 16:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617901079;
        bh=/ZNonnVvJf8TVEI5fHURSn+FdH/9H7lo0rxmwdxIEcw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=cShOX9ZUA3azSBUoknrPAWWS0N37VHpG7doQjfy7+ItILHntTKF/JR1E5GLw93Mdx
         5CUL1do84tp4UhfmDxDO1y5UMlMqJ2ADwOD60+kStRm3HJ7g6JWtvVnkahVdnju7Wb
         UrUXQfkj82ZVoY9ou1M822gpvStntBqE+L7Jy5D7HTkoSfz8jAMTHPQJSvevJuc2F8
         +sN/S0UiOYhDUWkCASC7I+6u/sj6XVAwLxrHMKRAmCrcl5HI1K0DQNicofx5yanooS
         gAXpRd8WOJe8RHEUxCZ7Z4dhrs4xo8OmU91GlssiuZ5ukApcWOkNnthN8GbHBWNKUO
         UctgcSHxb1Y4A==
Date:   Thu, 8 Apr 2021 11:57:58 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        gregkh@linuxfoundation.org, jonathan.cameron@huawei.com,
        song.bao.hua@hisilicon.com, prime.zeng@huawei.com,
        linux-doc@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH 3/4] docs: Add documentation for HiSilicon PTT device
 driver
Message-ID: <20210408165758.GA1935187@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ecc2177-1c3d-9899-923d-9514f652bb4e@hisilicon.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 08, 2021 at 09:22:52PM +0800, Yicong Yang wrote:
> On 2021/4/8 2:55, Bjorn Helgaas wrote:
> > On Tue, Apr 06, 2021 at 08:45:53PM +0800, Yicong Yang wrote:

> >> +On Kunpeng 930 SoC, the PCIe root complex is composed of several
> >> +PCIe cores.
> 
> > Can you connect "Kunpeng 930" to something in the kernel tree?
> > "git grep -i kunpeng" shows nothing that's obviously relevant.
> > I assume there's a related driver in drivers/pci/controller/?
> 
> Kunpeng 930 is the product name of Hip09 platform. The PCIe
> controller uses the generic PCIe driver based on ACPI.

I guess I'm just looking for a hint to help users know when to enable
the Kconfig for this.  Maybe the "HiSilicon" in the Kconfig help is
enough?  Maybe "Kunpeng 930" is not even necessary?  If "Kunpeng 930"
*is* necessary, there should be some way to relate it to something
else.

> >> +from the file, and the desired value written to the file to tune.
> > 
> >> +Tuning multiple events at the same time is not permitted, which means
> >> +you cannot read or write more than one tune file at one time.
> > 
> > I think this is obvious from the model, so the sentence doesn't really
> > add anything.  Each event is a separate file, and it's obvious that
> > there's no way to write to multiple files simultaneously.
> 
> from the usage we shown below this situation won't happen. I just worry
> that users may have a program to open multiple files at the same time and
> read/write simultaneously, so add this line here to mention the restriction.

How is this possible?  I don't think "writing multiple files
simultaneously" is even possible in the Linux syscall model.  I don't
think a user will do anything differently after reading "you cannot
read or write more than one tune file at one time."

> >> +- tx_path_rx_req_alloc_buf_level: watermark of RX requested
> >> +- tx_path_tx_req_alloc_buf_level: watermark of TX requested
> >> +
> >> +These events influence the watermark of the buffer allocated for each
> >> +type. RX means the inbound while Tx means outbound. For a busy
> >> +direction, you should increase the related buffer watermark to enhance
> >> +the performance.
> > 
> > Based on what you have written here, I would just write 2 to both
> > files to enhance the performance in both directions.  But obviously
> > there must be some tradeoff here, e.g., increasing Rx performance
> > comes at the cost of Tx performane.
> 
> the Rx buffer and Tx buffer are separate, so they won't influence
> each other.

Why would I write anything other than 2 to these files?  That's the
question I think this paragraph should answer.

> >> +9. data_format
> >> +--------------
> >> +
> >> +File to indicate the format of the traced TLP headers. User can also
> >> +specify the desired format of traced TLP headers. Available formats
> >> +are 4DW, 8DW which indicates the length of each TLP headers traced.
> >> +::
> >> +    $ cat data_format
> >> +    [4DW]    8DW
> >> +    $ echo 8 > data_format
> >> +    $ cat data_format
> >> +    4DW     [8DW]
> >> +
> >> +The traced TLP header format is different from the PCIe standard.
> > 
> > I'm confused.  Below you say the fields of the traced TLP header are
> > defined by the PCIe spec.  But here you say the format is *different*.
> > What exactly is different?
> 
> For the Request Header Format for 64-bit addressing of Memory, defind in
> PCIe spec 4.0, Figure 2-15, the 1st DW is like:
> 
> Byte 0 > [Fmt] [Type] [T9] [Tc] [T8] [Attr] [LN] [TH] ... [Length]
> 
> some are recorded in our traced header like below, which some are not.
> that's what I mean the format of the header are different. But for a
> certain field like 'Fmt', the meaning keeps same with what Spec defined.
> that's what I mean the fields definition of our traced header keep same
> with the Spec.

Ah, that helps a lot, thank you.  Maybe you could say something along
the lines of this:

  When using the 8DW data format, the entire TLP header is logged.
  For example, the TLP header for Memory Reads with 64-bit addresses
  is shown in PCIe r5.0, Figure 2-17; the header for Configuration
  Requests is shown in Figure 2.20, etc.

  In addition, 8DW trace buffer entries contain a timestamp and
  possibly a prefix, e.g., a PASID TLP prefix (see Figure 6-20).  TLPs
  may include more than one prefix, but only one can be logged in
  trace buffer entries.

  When using the 4DW data format, DW0 of the trace buffer entry
  contains selected fields of DW0 of the TLP, together with a
  timestamp.  DW1-DW3 of the trace buffer entry contain DW1-DW3
  directly from the TLP header.

This looks like a really cool device.  I wish we had this for more
platforms.

Bjorn
