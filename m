Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37A58463BEA
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 17:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244027AbhK3QjL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 11:39:11 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:56127 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238032AbhK3QjJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 11:39:09 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 57BBE580131;
        Tue, 30 Nov 2021 11:35:49 -0500 (EST)
Received: from imap47 ([10.202.2.97])
  by compute3.internal (MEProxy); Tue, 30 Nov 2021 11:35:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm3; bh=jY6BiEiqqEX3r2Q5KUj5NScjlUZf
        fg61Yq1tlm97XYA=; b=jyB3/dh+y7c9vt/oLRpNSfNC/oiUOK/VJK8JZyNRCFOc
        bbeesyoIbl0CSqNRur2TB14V/liIrJm4KX65Ik5ZGo1zySpONG4YtTYzxS9CUKqo
        NadBNNjzdNLypkNQ0jqUx8ihBa7tFdlcJZ+mGSzOsWBPYZXi4QI48dbCjTPCKc5Y
        imDYW1yZvArYKhwyp0CUULMH+TDwPYZwXkrriKohEY1X5H/zQAaPyMzgBO7q5Cg7
        K35cAUIOssmHF9cib9gSoodhxLIIP6rEjUQRWSyBeJDJDGwUQEyFCCbTWHTAflun
        Gf1K62APOkgUU9E3NuoB2p/MdnsLAq+TZzTuNdzy4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=jY6BiE
        iqqEX3r2Q5KUj5NScjlUZffg61Yq1tlm97XYA=; b=exCdb3Nlcw6TyjODvHWX5M
        AR4JsRPKMCpnb4auq1n3u4nBIjfoQu+GhUoAi2rLTUxifFSh1/E9pI4pOM214S1n
        y7F99nqoJl5pf6X6pnTbXPgmd2Ff9LSDFno6mF3LCa7cu6ToYwDsg40cFloTMm6X
        T8BPVW9CqytvDYZud5nRlSMqScxpaRp2wizBe8djXxwO1vWYLmUEasWdoecS7S+/
        up8vIDqSqu9xxrKrZo0PojWXnjMUYnv+3Zw1W3tqMOvQOO/bs2kXY8Q1KOcpBK3U
        opHeutP31WvAe7KgYdw6A3LDPVHkLeiyINTvGjDU/vMG4EO8OX7MknPAdljc9YGg
        ==
X-ME-Sender: <xms:5FKmYShZZhFZh_IqmL6zHDeut9llF2lsBwsB5ob6JIMrKfKQufKHZA>
    <xme:5FKmYTAChIUwXNvY3MibWHPgF9kZgGL3xHeFJpb6V8JNAtxzdQuVdbF_rQ4CJOJpV
    QQep3Wcyj173qdgvIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddriedugdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfufhvvghn
    ucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrth
    htvghrnhepvedvgeevuddvvedvgfelfeegiedvgeehieeutdelvedvieevveeljeefvedt
    leehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdruggv
    vh
X-ME-Proxy: <xmx:5FKmYaFmzA6NDcLu9LRzcsdsr0jSn8GM_Cu20YrnjBaUO3k5fIxcfA>
    <xmx:5FKmYbTEi3CfNwGKFxUyj_LkA-infyZrfKX1l9P8p3GPOnW5tEiHUQ>
    <xmx:5FKmYfw8cCiPIb3PwaLkom8BOFImZuMrUAtPEuPt0dPAg__QyHfuAA>
    <xmx:5VKmYUoGkNdE6vr5qBJo0dj_y2WXJf4TWEUMQSqeDoNjOG5NFDuvdg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id BDB3C27407E3; Tue, 30 Nov 2021 11:35:48 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4410-g5528bb82a8-fm-20211130.003-g5528bb82
Mime-Version: 1.0
Message-Id: <0f3c9f9e-caf9-462a-ba8d-882266d4c7c4@www.fastmail.com>
In-Reply-To: <20211130160338.GA2739234@bhelgaas>
References: <20211130160338.GA2739234@bhelgaas>
Date:   Tue, 30 Nov 2021 17:35:16 +0100
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Bjorn Helgaas" <helgaas@kernel.org>,
        "Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org>
Cc:     "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>, svarbanov@mm-sol.com,
        bjorn.andersson@linaro.org, "Rob Herring" <robh@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, "kernel test robot" <lkp@intel.com>,
        "Marc Zyngier" <maz@kernel.org>,
        "Alyssa Rosenzweig" <alyssa@rosenzweig.io>
Subject: Re: [PATCH] PCI: qcom: Fix warning generated due to the incorrect data type
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Tue, Nov 30, 2021, at 17:03, Bjorn Helgaas wrote:
> [+cc Marc, Alyssa, Sven for RID-to-SID mapping insight.  The patch at
> https://lore.kernel.org/all/20211130062137.GD205712@thinkpad/ merely
> fixes a warning.  My meta-question is about the qcom BDF-to-SID
> mapping.]
>
> On Tue, Nov 30, 2021 at 11:51:37AM +0530, Manivannan Sadhasivam wrote:
>> On Mon, Nov 29, 2021 at 09:36:14PM -0600, Bjorn Helgaas wrote:
>> > ...
>> > I'm also curious why pcie-qcom.c is the only driver that does this.
>> > "iommu-map" is not specific to qcom, but no other drivers do similar
>> > things with it.
>> 
>> Yes, on the recent qcom platforms starting from sm8250 we need to program
>> the BDF to SID mapping in the controller and that's the reason we are
>> extracting the "iommu-map" property in DT.
>
> This sounds like something that may not really be specific to sm8250.

So a single IOMMU can possibly differentiate between N different devices [1].
Each device [1] is identified by some number which is called sid (stream id?
security id? who knows.) on Apple hardware (and apparently also on qcom).
Now I don't know much about PCI but the way I understand it is that the
bus/device/function tuple can be used to uniquely identify a single device on the bus.
All iommu-map does is to provide the mapping between those two different spaces [2].

For most iommus this seems to be just a static mapping that's hardwired in silicon
and I think that's why almost no PCI driver needs to care about it: The iommu
core will just use it to convert the PCI requester ID to a number the iommu
driver understands.

Apple's frankenchip however allows to configure this mapping from software
after a device has been attached and that's why we need that special code inside
the PCI driver: We have to make sure that whatever is configured inside iommu-map
(and used by the iommu core to match PCI devices to iommu groups) matches to what
the HW does.

I can only assume that qcom does something similar. It looks like the qcom HW can be
fully configured during probe time though while we really have to wait until a device
is attached for the Apple chip (mostly because we only have 16 slots there).


Hope that helps.


Best,

Sven



[1] Technically the smallest unit are iommu groups which can contain multiple
devices but we can just ignore that. The iommu code will do the correct thing
if it gets told that two PCI devices have the same identification number.

[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/iommu/of_iommu.c#n53
