Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6149F105EB5
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2019 03:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfKVCnK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Nov 2019 21:43:10 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:33133 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfKVCnI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Nov 2019 21:43:08 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20191122024302epoutp0174791269d55d05bb93e72905b90553d3~ZW_S6h2Wz2789327893epoutp01H
        for <linux-pci@vger.kernel.org>; Fri, 22 Nov 2019 02:43:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20191122024302epoutp0174791269d55d05bb93e72905b90553d3~ZW_S6h2Wz2789327893epoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1574390582;
        bh=Px4SlZ5apSRJazVEKcmp2ZxkKUBgkoNX88YE/Ke2mS8=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=uS/xP7ZJpaE7dm8BpmRQsfsNp+IZcUg8QFTfJ77zgVFHH52rWHPDbiGYlIP37BRb+
         H+688o1yjmaaWNVvK3/KrJgnqApsp+/ffDa3RdZMSdKeWSj5vGtiMiqpEshOJ0LxEa
         cGi/4/TDzTPyV5HKDyyQ+2Cumwklqc7PHY6czK3Y=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20191122024302epcas5p46e8dff0af37d1b4ae884d7573ce74928~ZW_SZSdhY0340703407epcas5p4L;
        Fri, 22 Nov 2019 02:43:02 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        40.DD.04078.53B47DD5; Fri, 22 Nov 2019 11:43:02 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20191122024301epcas5p15162a4693f1d585dcd42d9ff151d1c54~ZW_Rs2dWT2878528785epcas5p1p;
        Fri, 22 Nov 2019 02:43:01 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20191122024301epsmtrp1632ce3d4ffe6c33d6edf0028bac333cf~ZW_Rr_jHR1274412744epsmtrp1k;
        Fri, 22 Nov 2019 02:43:01 +0000 (GMT)
X-AuditID: b6c32a49-5edff70000000fee-f4-5dd74b3557fa
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B6.C7.03654.53B47DD5; Fri, 22 Nov 2019 11:43:01 +0900 (KST)
Received: from pankajdubey02 (unknown [107.111.85.21]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20191122024259epsmtip1f209f41be9c8c724411192d7ce2ac4cd~ZW_PzFe0c2388123881epsmtip1Y;
        Fri, 22 Nov 2019 02:42:59 +0000 (GMT)
From:   "Pankaj Dubey" <pankaj.dubey@samsung.com>
To:     "'Andrew Murray'" <andrew.murray@arm.com>,
        "'Anvesh Salveru'" <anvesh.s@samsung.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <kishon@ti.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
In-Reply-To: <20191121160842.GC43905@e119886-lin.cambridge.arm.com>
Subject: RE: [PATCH v4 1/2] phy: core: add phy_property_present method
Date:   Fri, 22 Nov 2019 08:12:57 +0530
Message-ID: <025701d5a0de$8e8b37d0$aba1a770$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQE1rVtOHv1BqgLHLDW+5IttHzLvfAFs3nFMAYnCwPkCRa1ydaisfipw
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLKsWRmVeSWpSXmKPExsWy7bCmpq6Z9/VYg/MHmSya/29ntTi7ayGr
        xZKmDItddzvYLVZ8mcluceFpD5vF5V1z2CzOzjvOZvHm9wt2i6XXLzJZtO49wu7A7bFm3hpG
        j52z7rJ7LNhU6rFpVSebR9+WVYweW/Z/ZvQ4fmM7k8fnTXIBHFFcNimpOZllqUX6dglcGfdW
        fGIqWKNaserzG/YGxvuyXYwcHBICJhIT9kt3MXJxCAnsZpTY1X2eCcL5xCgxtamJBcL5xiix
        +d4nIIcTrOP9/FNsEIm9QC29/ewgCSGB14wSk14LgNhsAvoS537MYwWxRQSiJBbe28oK0sAs
        8JFR4m/3ArAEp4CzRPu8CewgdwgLuEmsexgIEmYRUJU48OUxWAmvgKVE/4MN7BC2oMTJmU/A
        jmAWkJfY/nYOM8RBChI/ny6D2uUmcevuTkaIGnGJl0ePsIPslRBYxC5xr/sB1AcuEv8OtrJB
        2MISr45vYYewpSRe9rdB2fkSPxZPYoZobmGUmHx8LitEwl7iwJU5LCBHMwtoSqzfpQ+xjE+i
        9/cTJkiY8kp0tAlBVKtJfH9+BupOGYmHzUuZIGwPiSvnfjNPYFScheS1WUhem4XkhVkIyxYw
        sqxilEwtKM5NTy02LTDMSy3XK07MLS7NS9dLzs/dxAhOZFqeOxhnnfM5xCjAwajEwzuh/Fqs
        EGtiWXFl7iFGCQ5mJRHePdevxArxpiRWVqUW5ccXleakFh9ilOZgURLnncR6NUZIID2xJDU7
        NbUgtQgmy8TBKdXAmHrQZYPEF758rZcrLKfeYNKc+lbqr+mJMw7XzzXN9VNXO8C90SBP+cGl
        MB/rfYcO1/lmS06zaj9rkKtsEWalatdcbB7fwOlyXlKmYecL18epiUsPFqZH54RkyXftsmD6
        sMEpwO+ta0oYS8TGB0c5l5lfPOZuEcGg3RTzjEV+vZ/QORdrg34lluKMREMt5qLiRADz7g5N
        YAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsWy7bCSnK6p9/VYg79f+S2a/29ntTi7ayGr
        xZKmDItddzvYLVZ8mcluceFpD5vF5V1z2CzOzjvOZvHm9wt2i6XXLzJZtO49wu7A7bFm3hpG
        j52z7rJ7LNhU6rFpVSebR9+WVYweW/Z/ZvQ4fmM7k8fnTXIBHFFcNimpOZllqUX6dglcGfdW
        fGIqWKNaserzG/YGxvuyXYycHBICJhLv559i62Lk4hAS2M0ocfl3NzNEQkZi8uoVrBC2sMTK
        f8/ZIYpeMkp0TTnHDpJgE9CXOPdjHliRiECUxN/PN1hAipgFfjNKLLv1ngWio4VJYsOFFWBj
        OQWcJdrnTQDq5uAQFnCTWPcwECTMIqAqceDLY7BBvAKWEv0PNrBD2IISJ2c+YQEpZxbQk2jb
        yAgSZhaQl9j+dg7UoQoSP58ug7rBTeLW3Z1QNeISL48eYZ/AKDwLyaRZCJNmIZk0C0nHAkaW
        VYySqQXFuem5xYYFhnmp5XrFibnFpXnpesn5uZsYwfGopbmD8fKS+EOMAhyMSjy8E8qvxQqx
        JpYVV+YeYpTgYFYS4d1z/UqsEG9KYmVValF+fFFpTmrxIUZpDhYlcd6neccihQTSE0tSs1NT
        C1KLYLJMHJxSDYwNrKymbe7nrvvbNK4tu6kl+u1OM8dsvY3ezc83c+t+1Of3b71z5fjvdo6I
        dSfseOZdiHuYvOpc74KgOVbrfx5hFLn65W/mg8lq1w9m3/3XuHv1lKiWp8IVDcd87EJifLM6
        p/c/2npSIukx84MQu6sd+VF1RvyXfAOenwqfpZ4kXdV1c/LyM+pKLMUZiYZazEXFiQACbQoB
        wwIAAA==
X-CMS-MailID: 20191122024301epcas5p15162a4693f1d585dcd42d9ff151d1c54
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20191121032036epcas5p1ec12cabed1104c131a3cab202a180c21
References: <1574306408-4360-1-git-send-email-anvesh.s@samsung.com>
        <CGME20191121032036epcas5p1ec12cabed1104c131a3cab202a180c21@epcas5p1.samsung.com>
        <1574306408-4360-2-git-send-email-anvesh.s@samsung.com>
        <20191121160842.GC43905@e119886-lin.cambridge.arm.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Andrew Murray <andrew.murray@arm.com>
> Sent: Thursday, November 21, 2019 9:39 PM
> To: Anvesh Salveru <anvesh.s@samsung.com>
> Cc: linux-kernel@vger.kernel.org; linux-pci@vger.kernel.org;
> jingoohan1@gmail.com; gustavo.pimentel@synopsys.com;
> pankaj.dubey@samsung.com; lorenzo.pieralisi@arm.com;
> bhelgaas@google.com; kishon@ti.com; robh+dt@kernel.org;
> mark.rutland@arm.com
> Subject: Re: [PATCH v4 1/2] phy: core: add phy_property_present method
> 
> On Thu, Nov 21, 2019 at 08:50:07AM +0530, Anvesh Salveru wrote:
> > In some platforms, we need information of phy properties in the
> > controller drivers. This patch adds a new phy_property_present()
> > method which can be used to check if some property exists in PHY or
> > not.
> >
> > In case of DesignWare PCIe controller, we need to write into
> > controller register to specify about ZRX-DC compliance property of the
> > PHY, which reduces the power consumption during lower power states.
> >
> > Signed-off-by: Anvesh Salveru <anvesh.s@samsung.com>
> > Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> > ---
> >  drivers/phy/phy-core.c  | 26 ++++++++++++++++++++++++++
> > include/linux/phy/phy.h |  8 ++++++++
> >  2 files changed, 34 insertions(+)
> >
> > diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c index
> > b04f4fe..0a62eca 100644
> > --- a/drivers/phy/phy-core.c
> > +++ b/drivers/phy/phy-core.c
> > @@ -420,6 +420,32 @@ int phy_calibrate(struct phy *phy)
> > EXPORT_SYMBOL_GPL(phy_calibrate);
> >
> >  /**
> > + * phy_property_present() - checks if the property is present in PHY
> > + * @phy: the phy returned by phy_get()
> > + * @property: name of the property to check
> > + *
> > + * Used to check if the given property is present in PHY. PHY drivers
> > + * can implement this callback function to expose PHY properties to
> > + * controller drivers.
> > + *
> > + * Returns: true if property exists, false otherwise  */ bool
> > +phy_property_present(struct phy *phy, const char *property) {
> > +	bool ret;
> > +
> > +	if (!phy || !phy->ops->property_present)
> > +		return false;
> > +
> > +	mutex_lock(&phy->mutex);
> > +	ret = phy->ops->property_present(phy, property);
> 
> I don't understand why it is necessary to require every phy driver to
implement
> this. Why can't the phy-core driver look up the device node of the given
phy?
> 

No specific reason.

We just went ahead and implemented this similar to other API in phy-core.c
file where it redirects call to platform specific phy driver. As  you
pointed out in this case, it makes sense to keep it in phy-core driver
itself, as platform specific phy driver is not going to do anything which is
really dependent on the PHY. 
We will wait for further review comments on this patch, and then will take
up your suggestion in next patchset.

Thanks for review.
Pankaj Dubey
> Thanks,
> 
> Andrew Murray
> 
> > +	mutex_unlock(&phy->mutex);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(phy_property_present);
> > +
> > +/**
> >   * phy_configure() - Changes the phy parameters
> >   * @phy: the phy returned by phy_get()
> >   * @opts: New configuration to apply
> > diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h index
> > 15032f14..3dd8f3c 100644
> > --- a/include/linux/phy/phy.h
> > +++ b/include/linux/phy/phy.h
> > @@ -61,6 +61,7 @@ union phy_configure_opts {
> >   * @reset: resetting the phy
> >   * @calibrate: calibrate the phy
> >   * @release: ops to be performed while the consumer relinquishes the
> > PHY
> > + * @property_present: check if some property is present in PHY
> >   * @owner: the module owner containing the ops
> >   */
> >  struct phy_ops {
> > @@ -103,6 +104,7 @@ struct phy_ops {
> >  	int	(*reset)(struct phy *phy);
> >  	int	(*calibrate)(struct phy *phy);
> >  	void	(*release)(struct phy *phy);
> > +	bool	(*property_present)(struct phy *phy, const char *property);
> >  	struct module *owner;
> >  };
> >
> > @@ -217,6 +219,7 @@ static inline enum phy_mode phy_get_mode(struct
> > phy *phy)  }  int phy_reset(struct phy *phy);  int
> > phy_calibrate(struct phy *phy);
> > +bool phy_property_present(struct phy *phy, const char *property);
> >  static inline int phy_get_bus_width(struct phy *phy)  {
> >  	return phy->attrs.bus_width;
> > @@ -354,6 +357,11 @@ static inline int phy_calibrate(struct phy *phy)
> >  	return -ENOSYS;
> >  }
> >
> > +static inline bool phy_property_present(struct phy *phy, const char
> > +*property) {
> > +	return false;
> > +}
> > +
> >  static inline int phy_configure(struct phy *phy,
> >  				union phy_configure_opts *opts)
> >  {
> > --
> > 2.7.4
> >

